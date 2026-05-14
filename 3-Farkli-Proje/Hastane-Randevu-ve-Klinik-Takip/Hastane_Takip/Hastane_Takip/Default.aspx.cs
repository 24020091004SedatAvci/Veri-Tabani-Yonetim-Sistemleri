using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Hastane_Takip
{
    public partial class _Default : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["HastaneDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KlinikleriGetir();
            }
        }

        private void KlinikleriGetir()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT 
                            ID,
                            KlinikAdi,
                            KatNo,
                            Uzmanlik
                        FROM Clinics
                        ORDER BY KlinikAdi ASC
                    ";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptClinics.DataSource = dt;
                    rptClinics.DataBind();

                    if (dt.Rows.Count == 0)
                    {
                        lblMesaj.Text = "Henüz klinik kaydı bulunamadı.";
                        lblMesaj.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMesaj.Text = "Klinikler getirilirken hata oluştu: " + ex.Message;
                lblMesaj.Visible = true;
            }
        }
    }
}