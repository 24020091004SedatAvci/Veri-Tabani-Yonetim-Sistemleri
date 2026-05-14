using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Hastane_Takip
{
    public partial class GunlukRandevuPlani : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["HastaneDB"].ConnectionString;

        private int DoktorId
        {
            get
            {
                int.TryParse(Request.QueryString["docId"], out int id);
                return id;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (DoktorId <= 0)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                txtTarih.Text = DateTime.Today.ToString("yyyy-MM-dd");

                DoktorBilgisiGetir();
                RandevulariGetir();
            }
        }

        protected void btnTarihGetir_Click(object sender, EventArgs e)
        {
            pnlRandevuDuzenle.Visible = false;
            pnlRecete.Visible = false;
            RandevulariGetir();
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
                        WHERE Doctors.ID = @DoktorID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@DoktorID", DoktorId);

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

        private DateTime SeciliTarihGetir()
        {
            if (DateTime.TryParse(txtTarih.Text, out DateTime tarih))
            {
                return tarih.Date;
            }

            return DateTime.Today;
        }

        private void RandevulariGetir()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT
                            Appointments.ID,
                            Appointments.HastaID,
                            Appointments.RandevuTarihi,
                            Appointments.Sikayet,
                            Patients.AdSoyad AS HastaAdi,
                            Patients.TCKimlik,
                            Patients.Telefon,
                            ISNULL(Prescriptions.ID, 0) AS ReceteID
                        FROM Appointments
                        INNER JOIN Patients ON Appointments.HastaID = Patients.ID
                        LEFT JOIN Prescriptions ON Appointments.ID = Prescriptions.RandevuID
                        WHERE Appointments.DoktorID = @DoktorID
                        AND CAST(Appointments.RandevuTarihi AS DATE) = @Tarih
                        ORDER BY Appointments.RandevuTarihi ASC
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@DoktorID", DoktorId);
                    cmd.Parameters.AddWithValue("@Tarih", SeciliTarihGetir());

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptRandevular.DataSource = dt;
                    rptRandevular.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        MesajGoster("Seçilen tarihte bu doktora ait randevu bulunamadı.", false);
                    }
                    else
                    {
                        lblMesaj.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Randevular getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void rptRandevular_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int randevuId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "RandevuDuzenle")
            {
                RandevuDuzenlemeFormunuDoldur(randevuId);
            }
            else if (e.CommandName == "RandevuSil")
            {
                RandevuSil(randevuId);
            }
            else if (e.CommandName == "ReceteIslem")
            {
                ReceteFormunuDoldur(randevuId);
            }
        }

        private void RandevuDuzenlemeFormunuDoldur(int randevuId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            ID,
                            RandevuTarihi,
                            Sikayet
                        FROM Appointments
                        WHERE ID = @RandevuID
                        AND DoktorID = @DoktorID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@RandevuID", randevuId);
                    cmd.Parameters.AddWithValue("@DoktorID", DoktorId);

                    conn.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        DateTime randevuTarihi = Convert.ToDateTime(dr["RandevuTarihi"]);

                        hfRandevuID.Value = dr["ID"].ToString();
                        txtDuzenleRandevuTarihi.Text = randevuTarihi.ToString("yyyy-MM-ddTHH:mm");
                        txtDuzenleSikayet.Text = dr["Sikayet"].ToString();

                        pnlRandevuDuzenle.Visible = true;
                        pnlRecete.Visible = false;
                        lblMesaj.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Randevu düzenleme bilgisi getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnRandevuGuncelle_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfRandevuID.Value, out int randevuId))
            {
                MesajGoster("Güncellenecek randevu bulunamadı.", false);
                return;
            }

            if (!DateTime.TryParse(txtDuzenleRandevuTarihi.Text, out DateTime yeniTarih))
            {
                MesajGoster("Randevu tarihi geçerli değil.", false);
                return;
            }

            string sikayet = txtDuzenleSikayet.Text.Trim();

            if (sikayet == "")
            {
                MesajGoster("Şikayet alanı boş bırakılamaz.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (RandevuCakismaVarMi(conn, randevuId, yeniTarih))
                    {
                        MesajGoster("Bu doktora seçilen tarih ve saatte başka bir randevu bulunmaktadır.", false);
                        return;
                    }

                    string query = @"
                        UPDATE Appointments
                        SET 
                            RandevuTarihi = @RandevuTarihi,
                            Sikayet = @Sikayet
                        WHERE ID = @RandevuID
                        AND DoktorID = @DoktorID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@RandevuTarihi", yeniTarih);
                    cmd.Parameters.AddWithValue("@Sikayet", sikayet);
                    cmd.Parameters.AddWithValue("@RandevuID", randevuId);
                    cmd.Parameters.AddWithValue("@DoktorID", DoktorId);

                    cmd.ExecuteNonQuery();

                    pnlRandevuDuzenle.Visible = false;

                    MesajGoster("Randevu başarıyla güncellendi.", true);
                    RandevulariGetir();
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Randevu güncellenirken hata oluştu: " + ex.Message, false);
            }
        }

        private bool RandevuCakismaVarMi(SqlConnection conn, int randevuId, DateTime yeniTarih)
        {
            string query = @"
                SELECT COUNT(*)
                FROM Appointments
                WHERE DoktorID = @DoktorID
                AND RandevuTarihi = @RandevuTarihi
                AND ID <> @RandevuID
            ";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@DoktorID", DoktorId);
            cmd.Parameters.AddWithValue("@RandevuTarihi", yeniTarih);
            cmd.Parameters.AddWithValue("@RandevuID", randevuId);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            return count > 0;
        }

        protected void btnRandevuIptal_Click(object sender, EventArgs e)
        {
            pnlRandevuDuzenle.Visible = false;
        }

        private void RandevuSil(int randevuId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        string deletePrescription = @"
                            DELETE FROM Prescriptions
                            WHERE RandevuID = @RandevuID
                        ";

                        SqlCommand cmdRecete = new SqlCommand(deletePrescription, conn, transaction);
                        cmdRecete.Parameters.AddWithValue("@RandevuID", randevuId);
                        cmdRecete.ExecuteNonQuery();

                        string deleteAppointment = @"
                            DELETE FROM Appointments
                            WHERE ID = @RandevuID
                            AND DoktorID = @DoktorID
                        ";

                        SqlCommand cmdRandevu = new SqlCommand(deleteAppointment, conn, transaction);
                        cmdRandevu.Parameters.AddWithValue("@RandevuID", randevuId);
                        cmdRandevu.Parameters.AddWithValue("@DoktorID", DoktorId);
                        cmdRandevu.ExecuteNonQuery();

                        transaction.Commit();

                        pnlRandevuDuzenle.Visible = false;
                        pnlRecete.Visible = false;

                        MesajGoster("Randevu başarıyla silindi.", true);
                        RandevulariGetir();
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
                MesajGoster("Randevu silinirken hata oluştu: " + ex.Message, false);
            }
        }

        private void ReceteFormunuDoldur(int randevuId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            ID,
                            RandevuID,
                            IlacListesi,
                            KullanimTalimati
                        FROM Prescriptions
                        WHERE RandevuID = @RandevuID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@RandevuID", randevuId);

                    conn.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    hfReceteRandevuID.Value = randevuId.ToString();

                    if (dr.Read())
                    {
                        hfReceteID.Value = dr["ID"].ToString();
                        txtIlacListesi.Text = dr["IlacListesi"].ToString();
                        txtKullanimTalimati.Text = dr["KullanimTalimati"].ToString();

                        ltReceteBaslik.Text = "Reçete Düzenle";
                        btnReceteSil.Visible = true;
                    }
                    else
                    {
                        hfReceteID.Value = "";
                        txtIlacListesi.Text = "";
                        txtKullanimTalimati.Text = "";

                        ltReceteBaslik.Text = "Reçete Ekle";
                        btnReceteSil.Visible = false;
                    }

                    pnlRecete.Visible = true;
                    pnlRandevuDuzenle.Visible = false;
                    lblMesaj.Visible = false;
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Reçete bilgisi getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnReceteKaydet_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfReceteRandevuID.Value, out int randevuId))
            {
                MesajGoster("Reçete yazılacak randevu bulunamadı.", false);
                return;
            }

            string ilacListesi = txtIlacListesi.Text.Trim();
            string kullanimTalimati = txtKullanimTalimati.Text.Trim();

            if (ilacListesi == "" || kullanimTalimati == "")
            {
                MesajGoster("İlaç listesi ve kullanım talimatı boş bırakılamaz.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (int.TryParse(hfReceteID.Value, out int receteId))
                    {
                        string updateQuery = @"
                            UPDATE Prescriptions
                            SET 
                                IlacListesi = @IlacListesi,
                                KullanimTalimati = @KullanimTalimati
                            WHERE ID = @ReceteID
                            AND RandevuID = @RandevuID
                        ";

                        SqlCommand cmd = new SqlCommand(updateQuery, conn);
                        cmd.Parameters.AddWithValue("@IlacListesi", ilacListesi);
                        cmd.Parameters.AddWithValue("@KullanimTalimati", kullanimTalimati);
                        cmd.Parameters.AddWithValue("@ReceteID", receteId);
                        cmd.Parameters.AddWithValue("@RandevuID", randevuId);

                        cmd.ExecuteNonQuery();

                        MesajGoster("Reçete başarıyla güncellendi.", true);
                    }
                    else
                    {
                        string insertQuery = @"
                            INSERT INTO Prescriptions
                            (RandevuID, IlacListesi, KullanimTalimati)
                            VALUES
                            (@RandevuID, @IlacListesi, @KullanimTalimati)
                        ";

                        SqlCommand cmd = new SqlCommand(insertQuery, conn);
                        cmd.Parameters.AddWithValue("@RandevuID", randevuId);
                        cmd.Parameters.AddWithValue("@IlacListesi", ilacListesi);
                        cmd.Parameters.AddWithValue("@KullanimTalimati", kullanimTalimati);

                        cmd.ExecuteNonQuery();

                        MesajGoster("Reçete başarıyla eklendi.", true);
                    }

                    pnlRecete.Visible = false;
                    RandevulariGetir();
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Reçete kaydedilirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnReceteSil_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfReceteID.Value, out int receteId))
            {
                MesajGoster("Silinecek reçete bulunamadı.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        DELETE FROM Prescriptions
                        WHERE ID = @ReceteID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ReceteID", receteId);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    pnlRecete.Visible = false;

                    MesajGoster("Reçete başarıyla silindi.", true);
                    RandevulariGetir();
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Reçete silinirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnReceteIptal_Click(object sender, EventArgs e)
        {
            pnlRecete.Visible = false;
        }

        private void MesajGoster(string mesaj, bool basarili)
        {
            lblMesaj.Text = mesaj;
            lblMesaj.CssClass = basarili ? "alert success" : "alert danger";
            lblMesaj.Visible = true;
        }
    }
}