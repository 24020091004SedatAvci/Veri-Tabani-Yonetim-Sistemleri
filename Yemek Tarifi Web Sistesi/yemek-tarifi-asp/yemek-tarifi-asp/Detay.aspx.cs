using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace yemek_tarifi_asp
{
    public partial class Detay : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["YemekDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                TarifDetayGetir(id);
                MalzemeleriGetir(id);
            }
        }

        void TarifDetayGetir(string id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT t.*, k.kategori_adi
                               FROM tarifler t
                               INNER JOIN kategoriler k ON t.kategori_id = k.id
                               WHERE t.id = @id";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    string tarifAdi = dr["tarif_adi"].ToString();
                    string kategoriAdi = dr["kategori_adi"].ToString();
                    string aciklama = dr["aciklama"].ToString();
                    string sure = dr["hazirlama_suresi"].ToString();
                    string foto = dr["fotograf_url"].ToString();

                    if (string.IsNullOrWhiteSpace(foto))
                    {
                        foto = "https://images.unsplash.com/photo-1547592166-23ac45744acd";
                    }

                    lblBaslik.Text = tarifAdi;
                    lblTarifAdi.Text = tarifAdi;
                    lblKategori.Text = kategoriAdi;
                    lblSure.Text = sure;

                    // Enter ile yazılan satırları ekranda alt alta gösterir
                    lblAciklama.Text = Server.HtmlEncode(aciklama).Replace("\n", "<br />");

                    imgTarif.ImageUrl = foto;
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }

                dr.Close();
            }
        }

        void MalzemeleriGetir(string id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT m.malzeme_adi, tm.miktar
                               FROM tarif_malzemeleri tm
                               INNER JOIN malzemeler m ON tm.malzeme_id = m.id
                               WHERE tm.tarif_id = @id";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.SelectCommand.Parameters.AddWithValue("@id", id);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvMalzemeler.DataSource = dt;
                gvMalzemeler.DataBind();

                pnlMalzemeYok.Visible = dt.Rows.Count == 0;
                gvMalzemeler.Visible = dt.Rows.Count > 0;
            }
        }
    }
}