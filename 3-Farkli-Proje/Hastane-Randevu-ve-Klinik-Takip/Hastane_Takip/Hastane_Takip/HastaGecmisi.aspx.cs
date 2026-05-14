using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Hastane_Takip
{
    public partial class HastaGecmisi : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["HastaneDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["patientId"], out int patientId))
                {
                    HastaBilgisiGetir(patientId);
                    HastaGecmisiniGetir(patientId);
                }
            }
        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            lblMesaj.Visible = false;
            pnlHastaBilgi.Visible = false;

            string tcKimlik = txtTCKimlikAra.Text.Trim();

            if (tcKimlik.Length != 11)
            {
                MesajGoster("TC kimlik 11 karakter olmalıdır.", false);
                return;
            }

            int hastaId = HastaIdBul(tcKimlik);

            if (hastaId <= 0)
            {
                MesajGoster("Bu TC kimlik numarasına ait hasta kaydı bulunamadı.", false);
                return;
            }

            HastaBilgisiGetir(hastaId);
            HastaGecmisiniGetir(hastaId);
        }

        private int HastaIdBul(string tcKimlik)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT ID
                        FROM Patients
                        WHERE TCKimlik = @TCKimlik
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TCKimlik", tcKimlik);

                    conn.Open();

                    object result = cmd.ExecuteScalar();

                    if (result == null)
                    {
                        return 0;
                    }

                    return Convert.ToInt32(result);
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Hasta aranırken hata oluştu: " + ex.Message, false);
                return 0;
            }
        }

        private void HastaBilgisiGetir(int hastaId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            ID,
                            TCKimlik,
                            AdSoyad,
                            Telefon,
                            KanGrubu
                        FROM Patients
                        WHERE ID = @HastaID
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@HastaID", hastaId);

                    conn.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ltHastaAdSoyad.Text = dr["AdSoyad"].ToString();
                        ltTCKimlik.Text = dr["TCKimlik"].ToString();
                        ltTelefon.Text = dr["Telefon"].ToString();
                        ltKanGrubu.Text = dr["KanGrubu"].ToString();

                        pnlHastaBilgi.Visible = true;
                    }
                    else
                    {
                        MesajGoster("Hasta bilgisi bulunamadı.", false);
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Hasta bilgisi getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        private void HastaGecmisiniGetir(int hastaId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            Appointments.ID,
                            Appointments.RandevuTarihi,
                            Appointments.Sikayet,
                            Doctors.AdSoyad AS DoktorAdi,
                            Doctors.Unvan,
                            Clinics.KlinikAdi,
                            ISNULL(Prescriptions.IlacListesi, '') AS IlacListesi,
                            ISNULL(Prescriptions.KullanimTalimati, '') AS KullanimTalimati
                        FROM Appointments
                        INNER JOIN Doctors ON Appointments.DoktorID = Doctors.ID
                        INNER JOIN Clinics ON Doctors.KlinikID = Clinics.ID
                        LEFT JOIN Prescriptions ON Appointments.ID = Prescriptions.RandevuID
                        WHERE Appointments.HastaID = @HastaID
                        ORDER BY Appointments.RandevuTarihi DESC
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@HastaID", hastaId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptGecmis.DataSource = dt;
                    rptGecmis.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        MesajGoster("Bu hastaya ait randevu geçmişi bulunamadı.", false);
                    }
                }
            }
            catch (Exception ex)
            {
                MesajGoster("Hasta geçmişi getirilirken hata oluştu: " + ex.Message, false);
            }
        }

        private void MesajGoster(string mesaj, bool basarili)
        {
            lblMesaj.Text = mesaj;
            lblMesaj.CssClass = basarili ? "alert success" : "alert danger";
            lblMesaj.Visible = true;
        }
    }
}