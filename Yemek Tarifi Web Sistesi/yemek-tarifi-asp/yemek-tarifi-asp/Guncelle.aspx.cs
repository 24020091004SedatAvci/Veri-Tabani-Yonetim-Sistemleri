using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace yemek_tarifi_asp
{
    public partial class Guncelle : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["YemekDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("TarifCrud.aspx");
                    return;
                }

                hfId.Value = id;

                KategorileriGetir();
                TarifBilgileriniGetir(id);
            }
        }

        void KategorileriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM kategoriler ORDER BY kategori_adi ASC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlKategori.DataSource = dt;
                ddlKategori.DataTextField = "kategori_adi";
                ddlKategori.DataValueField = "id";
                ddlKategori.DataBind();
            }
        }

        void TarifBilgileriniGetir(string id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM tarifler WHERE id = @id";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtTarifAdi.Text = dr["tarif_adi"].ToString();
                    txtSure.Text = dr["hazirlama_suresi"].ToString();
                    txtFoto.Text = dr["fotograf_url"].ToString();
                    txtAciklama.Text = dr["aciklama"].ToString();

                    ddlKategori.SelectedValue = dr["kategori_id"].ToString();
                }
                else
                {
                    Response.Redirect("TarifCrud.aspx");
                }

                dr.Close();
            }
        }

        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"UPDATE tarifler
                               SET kategori_id = @kategori_id,
                                   tarif_adi = @tarif_adi,
                                   aciklama = @aciklama,
                                   hazirlama_suresi = @hazirlama_suresi,
                                   fotograf_url = @fotograf_url
                               WHERE id = @id";

                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@kategori_id", ddlKategori.SelectedValue);
                cmd.Parameters.AddWithValue("@tarif_adi", txtTarifAdi.Text);
                cmd.Parameters.AddWithValue("@aciklama", txtAciklama.Text);
                cmd.Parameters.AddWithValue("@hazirlama_suresi", txtSure.Text);
                cmd.Parameters.AddWithValue("@fotograf_url", txtFoto.Text);
                cmd.Parameters.AddWithValue("@id", hfId.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("TarifCrud.aspx");
        }
    }
}