
//MSSQL Bağlamak i.in kullanılan kütüphaneler;
using Microsoft.Data.SqlClient;
using System.Data;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace SepetUyg_WinForms
{
    public partial class UrunAdet : Form
    {
        //Database'imize bağlanma komutları
        string connStr = "Server=localhost;Database=SepetDB;User Id=Sedat;Password=1512;TrustServerCertificate=True;";
        int selectedMusteriId = -1;

        private void VerileriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    // Müşterileri çekiyoruz
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM müsteri", conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgvMusteriler.DataSource = dt; // Tablonun ismi neyse ona bağla
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Bağlantı patladı kanka: " + ex.Message);
                }
            }
        }


        //Tabloların yüklenmesi için gerekli fonksiyonlar
        private void MusterileriYukle()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    // DataGridView ismin formda neyse (dgvMusteriler gibi) onu kullan
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM müsteri", conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgvMusteriler.DataSource = dt; // Tabloyu tek hamlede doldurduk!
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Müşteri Yükleme Hatası: " + ex.Message);
                }
            }
        }

        private void UrunleriYukle(int musteriId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM sepet WHERE müsteri_id = @mid", conn);
                    cmd.Parameters.AddWithValue("@mid", musteriId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dgvSepet.DataSource = dt;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ürün Yükleme Hatası: " + ex.Message);
                }
            }
        }
        public UrunAdet()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (selectedMusteriId == -1) return;

            var onay = MessageBox.Show("Müşteriyi ve sepetini silmek istediğine emin misin?", "Onay", MessageBoxButtons.YesNo);
            if (onay == DialogResult.Yes)
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    // 1. Önce sepeti temizle
                    SqlCommand cmd1 = new SqlCommand("DELETE FROM sepet WHERE müsteri_id = @id", conn);
                    cmd1.Parameters.AddWithValue("@id", selectedMusteriId);
                    cmd1.ExecuteNonQuery();

                    // 2. Sonra müşteriyi sil
                    SqlCommand cmd2 = new SqlCommand("DELETE FROM müsteri WHERE müsteri_id = @id", conn);
                    cmd2.Parameters.AddWithValue("@id", selectedMusteriId);
                    cmd2.ExecuteNonQuery();

                    selectedMusteriId = -1;
                    MusterileriYukle();
                    dgvSepet.DataSource = null; // Alt tabloyu boşalt
                }
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            MusterileriYukle();
            dgvMusteriler.AllowUserToAddRows = false;
            dgvSepet.AllowUserToAddRows = false;
        }

        private void MusteriAdi_Enter(object sender, EventArgs e)
        {
            if (MusteriAdi.Text == "Müşteri Adı")
            {
                MusteriAdi.Text = "";
                MusteriAdi.ForeColor = Color.Black;
            }
        }

        private void MusteriAdi_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(MusteriAdi.Text))
            {
                MusteriAdi.Text = "Müşteri Adı";
                MusteriAdi.ForeColor = Color.Silver;
            }
        }

        private void Form1_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(MusteriAdi.Text))
            {
                MusteriAdi.Text = "Müşteri Adı";
                MusteriAdi.ForeColor = Color.Silver;
            }
        }

        private void SepeteEkleBtn_Click(object sender, EventArgs e)
        {

            // Hayalet yazı kontrolü
            if (MusteriAdi.Text == "Müşteri Adı" || string.IsNullOrWhiteSpace(MusteriAdi.Text)) return;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    // GETDATE() ile SQL tarafında tarih otomatik alınır
                    string sql = "INSERT INTO müsteri (müsteri_adi, tarih, durum) VALUES (@ad, GETDATE(), @durum)";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@ad", MusteriAdi.Text);
                    cmd.Parameters.AddWithValue("@durum", Durum.SelectedItem?.ToString() ?? "Aktif");

                    cmd.ExecuteNonQuery();
                    MusterileriYukle(); // Tabloyu tazele

                    // Kutuyu temizle ve hayalet yazıyı geri getir
                    MusteriAdi.Text = "Müşteri Adı";
                    MusteriAdi.ForeColor = Color.Silver;
                }
                catch (Exception ex) { MessageBox.Show("Ekleme Hatası: " + ex.Message); }
            }
        }


        private void UrunAdi_Enter(object sender, EventArgs e)
        {
            if (UrunAdi.Text == "Ürün Adı")
            {
                UrunAdi.Text = "";
                UrunAdi.ForeColor = Color.Black;
            }
        }

        private void UrunAdi_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UrunAdi.Text))
            {
                UrunAdi.Text = "Ürün Adı";
                UrunAdi.ForeColor = Color.Silver;
            }

        }

        private void UrunAdedi_Enter(object sender, EventArgs e)
        {
            if (UrunAdedi.Text == "Ürün Adedi")
            {
                UrunAdedi.Text = "";
                UrunAdedi.ForeColor = Color.Black;
            }

        }

        private void UrunAdedi_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UrunAdedi.Text))
            {
                UrunAdedi.Text = "Ürün Adedi";
                UrunAdedi.ForeColor = Color.Silver;
            }
        }

        private void UrunFiyati_Enter(object sender, EventArgs e)
        {
            if (UrunFiyati.Text == "Ürün Fiyatı")
            {
                UrunFiyati.Text = "";
                UrunFiyati.ForeColor = Color.Black;
            }
        }

        private void UrunFiyati_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UrunFiyati.Text))
            {
                UrunFiyati.Text = "Ürün Fiyatı";
                UrunFiyati.ForeColor = Color.Silver;
            }
        }

        private void dgvMusteriler_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                // "müsteri_id" sütun adının SQL'dekiyle aynı olduğundan emin ol
                selectedMusteriId = Convert.ToInt32(dgvMusteriler.Rows[e.RowIndex].Cells["müsteri_id"].Value);
                UrunleriYukle(selectedMusteriId);
            }
        }

        private void UrunEkleBtn_Click(object sender, EventArgs e)
        {
            if (selectedMusteriId == -1)
            {
                MessageBox.Show("Lütfen önce üst tablodan bir müşteri seç kanka!");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string sql = "INSERT INTO sepet (müsteri_id, ürün_adi, fiyat, adet) VALUES (@mid, @ad, @fiyat, @adet)";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@mid", selectedMusteriId);
                    cmd.Parameters.AddWithValue("@ad", UrunAdi.Text);
                    cmd.Parameters.AddWithValue("@fiyat", double.Parse(UrunFiyati.Text));
                    cmd.Parameters.AddWithValue("@adet", int.Parse(UrunAdedi.Text));

                    cmd.ExecuteNonQuery();
                    UrunleriYukle(selectedMusteriId); // Alt tabloyu tazele

                    // Alanları temizleme kısmı...
                }
                catch (Exception ex) { MessageBox.Show("Hata! Sayı girdiğinden emin ol: " + ex.Message); }
            }
        }

        private void UrunSilBtn_Click(object sender, EventArgs e)
        {
          
            // 1. Seçili satır kontrolü
            if (dgvSepet.CurrentRow == null || dgvSepet.CurrentRow.IsNewRow)
            {
                MessageBox.Show("Lütfen silinecek ürünü seçiniz.");
                return;
            }

            // 2. ID değerini al (SQL'deki kolon adı 'ürün_id' olmalıdır)
            int urunId = Convert.ToInt32(dgvSepet.CurrentRow.Cells["ürün_id"].Value);

            // 3. Kullanıcı onayı
            DialogResult result = MessageBox.Show("Ürünü silmek istediğinize emin misiniz?", "Silme Onayı", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);

            if (result == DialogResult.Yes)
            {
                using (SqlConnection conn = new SqlConnection(connStr)) //
                {
                    try
                    {
                        conn.Open();
                        string query = "DELETE FROM sepet WHERE ürün_id = @id"; //
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@id", urunId);

                        cmd.ExecuteNonQuery();

                        // 4. Tabloyu yenile
                        UrunleriYukle(selectedMusteriId); //
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Hata: " + ex.Message);
                    }
                }
            
        }
    }
    }
}
    
