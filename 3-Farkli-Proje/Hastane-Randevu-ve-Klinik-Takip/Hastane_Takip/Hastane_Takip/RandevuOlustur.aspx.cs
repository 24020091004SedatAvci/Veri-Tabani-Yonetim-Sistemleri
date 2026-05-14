using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Hastane_Takip
{
    public partial class RandevuOlustur : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["HastaneDB"].ConnectionString;

        private int DoctorId
        {
            get
            {
                int.TryParse(Request.QueryString["doctorId"], out int id);
                return id;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (DoctorId <= 0)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                DoktorBilgisiGetir();
            }
        }

        private void DoktorBilgisiGetir()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            Doctors.AdSoyad,
                            Doctors.Unvan,
                            Clinics.KlinikAdi
                        FROM Doctors
                        INNER JOIN Clinics ON Doctors.KlinikID = Clinics.ID
                        WHERE Doctors.ID = @doctorId
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@doctorId", DoctorId);

                    conn.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ltDoktorBilgi.Text =
                            dr["Unvan"].ToString() + " " +
                            dr["AdSoyad"].ToString() + " - " +
                            dr["KlinikAdi"].ToString();
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Doktor bilgisi getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            lblMesaj.Visible = false;

            string tcKimlik = txtTCKimlik.Text.Trim();
            string adSoyad = txtHastaAdSoyad.Text.Trim();
            string telefon = txtTelefon.Text.Trim();
            string kanGrubu = ddlKanGrubu.SelectedValue;
            string sikayet = txtSikayet.Text.Trim();

            if (tcKimlik.Length != 11)
            {
                MesajGoster("TC kimlik 11 karakter olmalıdır.", false);
                return;
            }

            if (adSoyad == "" || telefon == "" || sikayet == "" || txtRandevuTarihi.Text == "")
            {
                MesajGoster("Lütfen tüm alanları doldurun.", false);
                return;
            }

            if (!DateTime.TryParse(txtRandevuTarihi.Text, out DateTime randevuTarihi))
            {
                MesajGoster("Randevu tarihi geçerli değil.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        int hastaId = HastaBulVeyaEkle(
                            conn,
                            transaction,
                            tcKimlik,
                            adSoyad,
                            telefon,
                            kanGrubu
                        );

                        bool randevuVarMi = RandevuCakismaVarMi(
                            conn,
                            transaction,
                            DoctorId,
                            randevuTarihi
                        );

                        if (randevuVarMi)
                        {
                            transaction.Rollback();
                            MesajGoster("Bu doktora seçilen tarih ve saatte zaten randevu alınmış.", false);
                            return;
                        }

                        string insertAppointment = @"
                            INSERT INTO Appointments
                            (HastaID, DoktorID, RandevuTarihi, Sikayet)
                            VALUES
                            (@HastaID, @DoktorID, @RandevuTarihi, @Sikayet)
                        ";

                        SqlCommand cmd = new SqlCommand(insertAppointment, conn, transaction);
                        cmd.Parameters.AddWithValue("@HastaID", hastaId);
                        cmd.Parameters.AddWithValue("@DoktorID", DoctorId);
                        cmd.Parameters.AddWithValue("@RandevuTarihi", randevuTarihi);
                        cmd.Parameters.AddWithValue("@Sikayet", sikayet);

                        cmd.ExecuteNonQuery();

                        transaction.Commit();

                        MesajGoster("Randevu başarıyla oluşturuldu.", true);

                        txtTCKimlik.Text = "";
                        txtHastaAdSoyad.Text = "";
                        txtTelefon.Text = "";
                        txtSikayet.Text = "";
                        txtRandevuTarihi.Text = "";
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Randevu oluşturulurken hata oluştu: " + ex.Message, false);
            }
        }

        private int HastaBulVeyaEkle(
            SqlConnection conn,
            SqlTransaction transaction,
            string tcKimlik,
            string adSoyad,
            string telefon,
            string kanGrubu)
        {
            string selectQuery = @"
                SELECT ID
                FROM Patients
                WHERE TCKimlik = @TCKimlik
            ";

            SqlCommand selectCmd = new SqlCommand(selectQuery, conn, transaction);
            selectCmd.Parameters.AddWithValue("@TCKimlik", tcKimlik);

            object result = selectCmd.ExecuteScalar();

            if (result != null)
            {
                return Convert.ToInt32(result);
            }

            string insertQuery = @"
                INSERT INTO Patients
                (TCKimlik, AdSoyad, Telefon, KanGrubu)
                OUTPUT INSERTED.ID
                VALUES
                (@TCKimlik, @AdSoyad, @Telefon, @KanGrubu)
            ";

            SqlCommand insertCmd = new SqlCommand(insertQuery, conn, transaction);
            insertCmd.Parameters.AddWithValue("@TCKimlik", tcKimlik);
            insertCmd.Parameters.AddWithValue("@AdSoyad", adSoyad);
            insertCmd.Parameters.AddWithValue("@Telefon", telefon);
            insertCmd.Parameters.AddWithValue("@KanGrubu", kanGrubu);

            return Convert.ToInt32(insertCmd.ExecuteScalar());
        }

        private bool RandevuCakismaVarMi(
            SqlConnection conn,
            SqlTransaction transaction,
            int doktorId,
            DateTime randevuTarihi)
        {
            string query = @"
                SELECT COUNT(*)
                FROM Appointments
                WHERE DoktorID = @DoktorID
                AND RandevuTarihi = @RandevuTarihi
            ";

            SqlCommand cmd = new SqlCommand(query, conn, transaction);
            cmd.Parameters.AddWithValue("@DoktorID", doktorId);
            cmd.Parameters.AddWithValue("@RandevuTarihi", randevuTarihi);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            return count > 0;
        }

        private void MesajGoster(string mesaj, bool basarili)
        {
            lblMesaj.Text = mesaj;
            lblMesaj.CssClass = basarili ? "alert success" : "alert danger";
            lblMesaj.Visible = true;
        }
    }
}