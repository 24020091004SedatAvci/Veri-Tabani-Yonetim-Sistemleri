namespace SepetUyg_WinForms
{
    partial class UrunAdet
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            MusteriAdi = new TextBox();
            Durum = new ComboBox();
            SepeteEkleBtn = new Button();
            SepetiSilBtn = new Button();
            UrunSilBtn = new Button();
            UrunAdi = new TextBox();
            UrunEkleBtn = new Button();
            UrunFiyati = new TextBox();
            UrunAdedi = new TextBox();
            dgvMusteriler = new DataGridView();
            dgvSepet = new DataGridView();
            label1 = new Label();
            ((System.ComponentModel.ISupportInitialize)dgvMusteriler).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dgvSepet).BeginInit();
            SuspendLayout();
            // 
            // MusteriAdi
            // 
            MusteriAdi.Font = new Font("Segoe UI Emoji", 12F);
            MusteriAdi.ForeColor = SystemColors.ButtonShadow;
            MusteriAdi.Location = new Point(214, 146);
            MusteriAdi.Multiline = true;
            MusteriAdi.Name = "MusteriAdi";
            MusteriAdi.Size = new Size(124, 33);
            MusteriAdi.TabIndex = 0;
            MusteriAdi.Text = "Müşteri Adı";
            MusteriAdi.TextChanged += textBox1_TextChanged;
            MusteriAdi.Enter += MusteriAdi_Enter;
            MusteriAdi.Leave += MusteriAdi_Leave;
            // 
            // Durum
            // 
            Durum.DropDownStyle = ComboBoxStyle.DropDownList;
            Durum.Font = new Font("Segoe UI Emoji", 14.25F, FontStyle.Regular, GraphicsUnit.Point, 0);
            Durum.FormattingEnabled = true;
            Durum.Items.AddRange(new object[] { "Aktif", "İptal", "Tamamlandı" });
            Durum.Location = new Point(378, 145);
            Durum.Name = "Durum";
            Durum.Size = new Size(150, 34);
            Durum.TabIndex = 1;
            Durum.SelectedIndexChanged += comboBox1_SelectedIndexChanged;
            // 
            // SepeteEkleBtn
            // 
            SepeteEkleBtn.Font = new Font("Segoe UI Emoji", 12F);
            SepeteEkleBtn.Location = new Point(655, 145);
            SepeteEkleBtn.Name = "SepeteEkleBtn";
            SepeteEkleBtn.Size = new Size(105, 34);
            SepeteEkleBtn.TabIndex = 2;
            SepeteEkleBtn.Text = "Sepete Ekle";
            SepeteEkleBtn.UseVisualStyleBackColor = true;
            SepeteEkleBtn.Click += SepeteEkleBtn_Click;
            // 
            // SepetiSilBtn
            // 
            SepetiSilBtn.Font = new Font("Segoe UI Emoji", 12F);
            SepetiSilBtn.Location = new Point(786, 145);
            SepetiSilBtn.Name = "SepetiSilBtn";
            SepetiSilBtn.Size = new Size(84, 34);
            SepetiSilBtn.TabIndex = 3;
            SepetiSilBtn.Text = "Sepeti Sil";
            SepetiSilBtn.UseVisualStyleBackColor = true;
            SepetiSilBtn.Click += button2_Click;
            // 
            // UrunSilBtn
            // 
            UrunSilBtn.Font = new Font("Segoe UI Emoji", 12F);
            UrunSilBtn.Location = new Point(786, 481);
            UrunSilBtn.Name = "UrunSilBtn";
            UrunSilBtn.Size = new Size(84, 34);
            UrunSilBtn.TabIndex = 7;
            UrunSilBtn.Text = "Ürün Sil";
            UrunSilBtn.UseVisualStyleBackColor = true;
            UrunSilBtn.Click += UrunSilBtn_Click;
            // 
            // UrunAdi
            // 
            UrunAdi.Font = new Font("Segoe UI Emoji", 12F);
            UrunAdi.ForeColor = SystemColors.ButtonShadow;
            UrunAdi.Location = new Point(197, 481);
            UrunAdi.Multiline = true;
            UrunAdi.Name = "UrunAdi";
            UrunAdi.Size = new Size(124, 34);
            UrunAdi.TabIndex = 4;
            UrunAdi.Text = "Ürün Adı";
            UrunAdi.Enter += UrunAdi_Enter;
            UrunAdi.Leave += UrunAdi_Leave;
            // 
            // UrunEkleBtn
            // 
            UrunEkleBtn.Font = new Font("Segoe UI Emoji", 12F);
            UrunEkleBtn.Location = new Point(665, 481);
            UrunEkleBtn.Name = "UrunEkleBtn";
            UrunEkleBtn.Size = new Size(95, 34);
            UrunEkleBtn.TabIndex = 6;
            UrunEkleBtn.Text = "Ürün Ekle";
            UrunEkleBtn.UseVisualStyleBackColor = true;
            UrunEkleBtn.Click += UrunEkleBtn_Click;
            // 
            // UrunFiyati
            // 
            UrunFiyati.Font = new Font("Segoe UI Emoji", 12F);
            UrunFiyati.ForeColor = SystemColors.ButtonShadow;
            UrunFiyati.Location = new Point(352, 481);
            UrunFiyati.Multiline = true;
            UrunFiyati.Name = "UrunFiyati";
            UrunFiyati.Size = new Size(124, 34);
            UrunFiyati.TabIndex = 8;
            UrunFiyati.Text = "Ürün Fiyatı";
            UrunFiyati.Enter += UrunFiyati_Enter;
            UrunFiyati.Leave += UrunFiyati_Leave;
            // 
            // UrunAdedi
            // 
            UrunAdedi.Font = new Font("Segoe UI Emoji", 12F);
            UrunAdedi.ForeColor = SystemColors.ButtonShadow;
            UrunAdedi.Location = new Point(499, 481);
            UrunAdedi.Multiline = true;
            UrunAdedi.Name = "UrunAdedi";
            UrunAdedi.Size = new Size(124, 34);
            UrunAdedi.TabIndex = 9;
            UrunAdedi.Text = "Ürün Adedi";
            UrunAdedi.Enter += UrunAdedi_Enter;
            UrunAdedi.Leave += UrunAdedi_Leave;
            // 
            // dgvMusteriler
            // 
            dgvMusteriler.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvMusteriler.BackgroundColor = Color.LightCyan;
            dgvMusteriler.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvMusteriler.Location = new Point(197, 185);
            dgvMusteriler.Name = "dgvMusteriler";
            dgvMusteriler.Size = new Size(673, 240);
            dgvMusteriler.TabIndex = 10;
            dgvMusteriler.CellClick += dgvMusteriler_CellClick;
            // 
            // dgvSepet
            // 
            dgvSepet.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dgvSepet.BackgroundColor = Color.LightCyan;
            dgvSepet.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvSepet.Location = new Point(197, 522);
            dgvSepet.Name = "dgvSepet";
            dgvSepet.Size = new Size(673, 240);
            dgvSepet.TabIndex = 11;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI Emoji", 36F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.ForeColor = SystemColors.ButtonHighlight;
            label1.Location = new Point(321, 23);
            label1.Name = "label1";
            label1.Size = new Size(420, 64);
            label1.TabIndex = 12;
            label1.Text = "Sepet Uygulaması";
            // 
            // UrunAdet
            // 
            AutoScaleDimensions = new SizeF(7F, 16F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.SlateBlue;
            ClientSize = new Size(1200, 774);
            Controls.Add(label1);
            Controls.Add(dgvSepet);
            Controls.Add(dgvMusteriler);
            Controls.Add(UrunAdedi);
            Controls.Add(UrunFiyati);
            Controls.Add(UrunSilBtn);
            Controls.Add(UrunEkleBtn);
            Controls.Add(UrunAdi);
            Controls.Add(SepetiSilBtn);
            Controls.Add(SepeteEkleBtn);
            Controls.Add(Durum);
            Controls.Add(MusteriAdi);
            Font = new Font("Segoe UI Emoji", 9F);
            Name = "UrunAdet";
            Text = "Form1";
            Load += Form1_Load;
            Leave += Form1_Leave;
            ((System.ComponentModel.ISupportInitialize)dgvMusteriler).EndInit();
            ((System.ComponentModel.ISupportInitialize)dgvSepet).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TextBox MusteriAdi;
        private ComboBox Durum;
        private Button SepeteEkleBtn;
        private Button SepetiSilBtn;
        private Button UrunSilBtn;
        private TextBox UrunAdi;
        private Button UrunEkleBtn;
        private TextBox UrunFiyati;
        private TextBox UrunAdedi;
        private DataGridView dgvMusteriler;
        private DataGridView dgvSepet;
        private Label label1;
    }
}
