using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace yemek_tarifi_asp
{
    public partial class Default : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["YemekDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TarifleriGetir();
            }
        }

        void TarifleriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT t.*, k.kategori_adi
                               FROM tarifler t
                               INNER JOIN kategoriler k ON t.kategori_id = k.id
                               ORDER BY t.id DESC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptTarifler.DataSource = dt;
                rptTarifler.DataBind();

                pnlBos.Visible = dt.Rows.Count == 0;
            }
        }
    }
}