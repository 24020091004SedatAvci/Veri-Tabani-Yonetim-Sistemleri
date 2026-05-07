using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SepetUyg_asp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string connStr = "Server=localhost; Database=SepetDB; User Id=Sedat; Password=1512; TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MusterileriListele();
            }
        }

        void MusterileriListele()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM müsteri", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMusteriler.DataSource = dt;
                gvMusteriler.DataBind();
            }
        }

        // Satırın üzerine tıklanınca seçilmesi için gereken JavaScript'i enjekte ediyoruz
        protected void gvMusteriler_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvMusteriler, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Müşteriyi seçmek için tıkla kanka";
                e.Row.Style["cursor"] = "pointer";
            }
        }

        protected void gvMusteriler_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlSepet.Visible = true;
            if (gvMusteriler.SelectedDataKey != null)
            {
                int seciliId = Convert.ToInt32(gvMusteriler.SelectedDataKey.Value);
                SepetListele(seciliId);
            }
        }

        void SepetListele(int musteriId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM sepet WHERE müsteri_id = @mid";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.SelectCommand.Parameters.AddWithValue("@mid", musteriId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSepet.DataSource = dt;
                gvSepet.DataBind();
            }
        }

        protected void btnMusteriEkle_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "INSERT INTO müsteri (müsteri_adi, tarih, durum) VALUES (@ad, GETDATE(), @durum)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ad", txtMusteriAdi.Text);
                cmd.Parameters.AddWithValue("@durum", ddlDurum.SelectedValue);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            MusterileriListele();
            txtMusteriAdi.Text = "";
        }

        protected void btnMusteriSil_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int mId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                // Önce sepet, sonra müşteri (Foreign Key kuralı)
                SqlCommand cmdSepet = new SqlCommand("DELETE FROM sepet WHERE müsteri_id = @id", conn);
                cmdSepet.Parameters.AddWithValue("@id", mId);
                cmdSepet.ExecuteNonQuery();

                SqlCommand cmdMusteri = new SqlCommand("DELETE FROM müsteri WHERE müsteri_id = @id", conn);
                cmdMusteri.Parameters.AddWithValue("@id", mId);
                cmdMusteri.ExecuteNonQuery();
            }
            MusterileriListele();
            pnlSepet.Visible = false;
        }

        protected void btnUrunSil_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int urunId = Convert.ToInt32(btn.CommandArgument);
            int musteriId = Convert.ToInt32(gvMusteriler.SelectedDataKey.Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM sepet WHERE ürün_id = @uid", conn);
                cmd.Parameters.AddWithValue("@uid", urunId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            SepetListele(musteriId);
        }

        protected void btnUrunEkle_Click(object sender, EventArgs e)
        {
            int musteriId = Convert.ToInt32(gvMusteriler.SelectedDataKey.Value);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "INSERT INTO sepet (müsteri_id, ürün_adi, fiyat, adet) VALUES (@mid, @u_ad, @fiyat, @adet)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@mid", musteriId);
                cmd.Parameters.AddWithValue("@u_ad", txtUrunAdi.Text);
                cmd.Parameters.AddWithValue("@fiyat", Convert.ToDecimal(txtFiyat.Text));
                cmd.Parameters.AddWithValue("@adet", Convert.ToInt32(txtAdet.Text));
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            SepetListele(musteriId);
            txtUrunAdi.Text = ""; txtFiyat.Text = ""; txtAdet.Text = "";
        }
    }
}