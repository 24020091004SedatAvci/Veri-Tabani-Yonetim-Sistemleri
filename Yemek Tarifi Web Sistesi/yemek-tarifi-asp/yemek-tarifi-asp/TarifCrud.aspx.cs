using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace yemek_tarifi_asp
{
    public partial class TarifCrud : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["YemekDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                KategorileriGetir();
                MalzemeleriGetir();
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

                gvTarifler.DataSource = dt;
                gvTarifler.DataBind();
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

        void MalzemeleriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM malzemeler ORDER BY malzeme_adi ASC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptMalzemeler.DataSource = dt;
                rptMalzemeler.DataBind();
            }
        }

        protected void btnEkle_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    string sqlTarif = @"INSERT INTO tarifler
                                        (kategori_id, tarif_adi, aciklama, hazirlama_suresi, fotograf_url)
                                        OUTPUT INSERTED.id
                                        VALUES (@kategori_id, @tarif_adi, @aciklama, @hazirlama_suresi, @fotograf_url)";

                    SqlCommand cmdTarif = new SqlCommand(sqlTarif, conn, trans);
                    cmdTarif.Parameters.AddWithValue("@kategori_id", ddlKategori.SelectedValue);
                    cmdTarif.Parameters.AddWithValue("@tarif_adi", txtTarifAdi.Text);
                    cmdTarif.Parameters.AddWithValue("@aciklama", txtAciklama.Text);
                    cmdTarif.Parameters.AddWithValue("@hazirlama_suresi", txtSure.Text);
                    cmdTarif.Parameters.AddWithValue("@fotograf_url", txtFoto.Text);

                    int tarifId = Convert.ToInt32(cmdTarif.ExecuteScalar());

                    foreach (RepeaterItem item in rptMalzemeler.Items)
                    {
                        CheckBox chk = (CheckBox)item.FindControl("chkMalzeme");
                        HiddenField hfId = (HiddenField)item.FindControl("hfMalzemeId");
                        TextBox txtMiktar = (TextBox)item.FindControl("txtMiktar");

                        if (chk != null && chk.Checked)
                        {
                            string sqlMalzeme = @"INSERT INTO tarif_malzemeleri
                                                  (tarif_id, malzeme_id, miktar)
                                                  VALUES (@tarif_id, @malzeme_id, @miktar)";

                            SqlCommand cmdMalzeme = new SqlCommand(sqlMalzeme, conn, trans);
                            cmdMalzeme.Parameters.AddWithValue("@tarif_id", tarifId);
                            cmdMalzeme.Parameters.AddWithValue("@malzeme_id", hfId.Value);
                            cmdMalzeme.Parameters.AddWithValue("@miktar", txtMiktar.Text);

                            cmdMalzeme.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();

                    lblMesaj.Text = "Tarif başarıyla eklendi.";
                    Temizle();

                    KategorileriGetir();
                    MalzemeleriGetir();
                    TarifleriGetir();
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMesaj.Text = "Hata: " + ex.Message;
                }
            }
        }

        protected void gvTarifler_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "DELETE FROM tarifler WHERE id = @id";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                TarifleriGetir();
            }
        }

        void Temizle()
        {
            txtTarifAdi.Text = "";
            txtSure.Text = "";
            txtFoto.Text = "";
            txtAciklama.Text = "";
        }
    }
}