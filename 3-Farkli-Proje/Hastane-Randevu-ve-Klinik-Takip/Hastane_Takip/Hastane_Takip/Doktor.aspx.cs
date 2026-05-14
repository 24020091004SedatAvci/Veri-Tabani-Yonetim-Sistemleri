using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Hastane_Takip
{
    public partial class Doktor : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["HastaneDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!int.TryParse(Request.QueryString["clinicId"], out int clinicId))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                DoktorlariGetir(clinicId);
            }
        }

        private void DoktorlariGetir(int clinicId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            Doctors.ID,
                            Doctors.AdSoyad,
                            Doctors.Unvan,
                            Clinics.KlinikAdi,
                            Clinics.KatNo,
                            Clinics.Uzmanlik
                        FROM Doctors
                        INNER JOIN Clinics ON Doctors.KlinikID = Clinics.ID
                        WHERE Doctors.KlinikID = @clinicId
                        ORDER BY Doctors.AdSoyad ASC
                    ";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@clinicId", clinicId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptDoctors.DataSource = dt;
                    rptDoctors.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        ltKlinikAdi.Text = dt.Rows[0]["KlinikAdi"].ToString() + " Doktorları";
                    }
                    else
                    {
                        ltKlinikAdi.Text = "Doktor Bulunamadı";
                        lblMesaj.Text = "Bu kliniğe ait doktor kaydı bulunamadı.";
                        lblMesaj.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMesaj.Text = "Doktorlar getirilirken hata oluştu: " + ex.Message;
                lblMesaj.Visible = true;
            }
        }
    }
}