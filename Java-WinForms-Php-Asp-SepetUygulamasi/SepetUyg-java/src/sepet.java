import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class sepet extends javax.swing.JFrame {
    
    private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(sepet.class.getName());
    private final String connStr = "jdbc:sqlserver://localhost:1433;databaseName=SepetDB;user=Sedat;password=1512;trustServerCertificate=true;";
    private int selectedMusteriId = -1;     
 
     
     
    public sepet() {
        initComponents();
        // 1. Ekran açıldığında müşterileri yükle
        loadMusteriler();

        // 2. Üst tabloya (Müşteriler) tıklandığında alt tabloyu (Sepet) doldur
        jTable2.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting() && jTable2.getSelectedRow() != -1) {
                selectedMusteriId = (int) jTable2.getValueAt(jTable2.getSelectedRow(), 0);
                loadUrunler(selectedMusteriId);
            }
        });

        // 3. Buton tıklama olaylarını bağlıyoruz (NetBeans silmesin diye buraya yazmak en güvenlisi)
        SepetEkleBtn.addActionListener(e -> addMusteri());
        UrunEkleBtn.addActionListener(e -> addUrun());
        
        // ---- YENİ EKLENEN SİLME BUTONLARI ----
        SepetSilBtn.addActionListener(e -> deleteMusteri());
        UrunSilBtn.addActionListener(e -> deleteUrun());
    
    }
    
    
    // ---- VERİTABANI METOTLARI BAŞLANGICI ----
    private void loadMusteriler() {
        DefaultTableModel model = (DefaultTableModel) jTable2.getModel();
        model.setRowCount(0);
        try (Connection conn = DriverManager.getConnection(connStr)) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM müsteri");
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("müsteri_id"),
                    rs.getString("müsteri_adi"),
                    rs.getDate("tarih"),
                    rs.getString("durum")
                });
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Müşteri Yükleme Hatası: " + e.getMessage());
        }
    }

    private void loadUrunler(int musteriId) {
        DefaultTableModel model = (DefaultTableModel) jTable3.getModel();
        model.setRowCount(0);
        try (Connection conn = DriverManager.getConnection(connStr)) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM sepet WHERE müsteri_id = ?");
            pstmt.setInt(1, musteriId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // Tablo sütun sırasına göre: ID, Ürün, Adet, Fiyat
                model.addRow(new Object[]{
                    rs.getInt("ürün_id"),
                    rs.getString("ürün_adi"),
                    rs.getInt("adet"),
                    rs.getDouble("fiyat") 
                });
            }
        } catch (SQLException e) {
             JOptionPane.showMessageDialog(this, "Ürün Yükleme Hatası: " + e.getMessage());
        }
    }

    private void addMusteri() {
        try (Connection conn = DriverManager.getConnection(connStr)) {
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO müsteri (müsteri_adi, tarih, durum) VALUES (?, GETDATE(), ?)");
            pstmt.setString(1, MüsteriAdi.getText()); 
            pstmt.setString(2, Durum.getSelectedItem().toString());
            
            pstmt.executeUpdate();
            loadMusteriler(); 
            MüsteriAdi.setText(""); 
            MüsteriAdi.setForeground(java.awt.Color.GRAY);
            MüsteriAdi.setText("Musteri Adi");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Müşteri Ekleme Hatası: " + e.getMessage());
        }
    }

    private void addUrun() {
        if (selectedMusteriId == -1) {
            JOptionPane.showMessageDialog(this, "Lütfen ürün eklemek için önce üst tablodan bir müşteri seçin!");
            return;
        }
        try (Connection conn = DriverManager.getConnection(connStr)) {
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO sepet (müsteri_id, ürün_adi, fiyat, adet) VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, selectedMusteriId);
            pstmt.setString(2, UrunAdi.getText());
            pstmt.setDouble(3, Double.parseDouble(UrunFiyat.getText()));
            pstmt.setInt(4, Integer.parseInt(UrunAdet.getText()));
            
            pstmt.executeUpdate();
            loadUrunler(selectedMusteriId); 
            
            // Ekledikten sonra kutuları varsayılan gri haline döndür
            UrunAdi.setForeground(java.awt.Color.GRAY);
            UrunAdi.setText("Urun Adi");
            UrunFiyat.setForeground(java.awt.Color.GRAY);
            UrunFiyat.setText("Urun Fiyati");
            UrunAdet.setForeground(java.awt.Color.GRAY);
            UrunAdet.setText("Urun Adedi");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Hata! Fiyat veya Adet kısmına sadece sayı girdiğinden emin ol:\n" + e.getMessage());
        }
    }
    
    private void deleteMusteri() {
        if (selectedMusteriId == -1) {
            JOptionPane.showMessageDialog(this, "Lütfen silmek için üst tablodan bir müşteri seçin!");
            return;
        }

        int onay = JOptionPane.showConfirmDialog(this, "Bu müşteriyi ve sepetindeki tüm ürünleri silmek istediğinize emin misiniz?", "Silme Onayı", JOptionPane.YES_NO_OPTION);
        if (onay == JOptionPane.YES_OPTION) {
            try (Connection conn = DriverManager.getConnection(connStr)) {
                // Önce müşterinin sepetindeki ürünleri sil (Veritabanı ilişkisi hatası almamak için)
                PreparedStatement pstmtSepet = conn.prepareStatement("DELETE FROM sepet WHERE müsteri_id = ?");
                pstmtSepet.setInt(1, selectedMusteriId);
                pstmtSepet.executeUpdate();

                // Sonra müşterinin kendisini sil
                PreparedStatement pstmtMusteri = conn.prepareStatement("DELETE FROM müsteri WHERE müsteri_id = ?");
                pstmtMusteri.setInt(1, selectedMusteriId);
                pstmtMusteri.executeUpdate();

                selectedMusteriId = -1; // Hafızadaki seçimi sıfırla
                loadMusteriler(); // Üst tabloyu yenile
                
                // Alt tabloyu (ürünleri) ekrandan temizle
                DefaultTableModel model = (DefaultTableModel) jTable3.getModel();
                model.setRowCount(0);

            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Silme Hatası: " + e.getMessage());
            }
        }
    }

    private void deleteUrun() {
        int selectedUrunRow = jTable3.getSelectedRow();
        if (selectedUrunRow == -1) {
            JOptionPane.showMessageDialog(this, "Lütfen silmek için alt tablodan bir ürün seçin!");
            return;
        }

        // Seçilen satırın 0. sütunundan (ürün_id) değerini al
        int urunId = (int) jTable3.getValueAt(selectedUrunRow, 0); 

        int onay = JOptionPane.showConfirmDialog(this, "Bu ürünü sepetten çıkarmak istediğinize emin misiniz?", "Silme Onayı", JOptionPane.YES_NO_OPTION);
        if (onay == JOptionPane.YES_OPTION) {
            try (Connection conn = DriverManager.getConnection(connStr)) {
                PreparedStatement pstmt = conn.prepareStatement("DELETE FROM sepet WHERE ürün_id = ?");
                pstmt.setInt(1, urunId);
                pstmt.executeUpdate();

                loadUrunler(selectedMusteriId); // Alt tabloyu yenile
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Ürün Silme Hatası: " + e.getMessage());
            }
        }
    }
    
    
    // ---- VERİTABANI METOTLARI BİTİŞİ ----
    
    
    
    
    
    

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        UrunSilBtn = new javax.swing.JButton();
        SepetSilBtn = new javax.swing.JButton();
        UrunFiyat = new javax.swing.JTextField();
        UrunAdi = new javax.swing.JTextField();
        UrunEkleBtn = new javax.swing.JButton();
        UrunAdet = new javax.swing.JTextField();
        SepetEkleBtn = new javax.swing.JButton();
        Durum = new javax.swing.JComboBox<>();
        MüsteriAdi = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable3 = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setBackground(new java.awt.Color(153, 153, 255));

        jPanel1.setBackground(new java.awt.Color(153, 153, 255));

        jLabel1.setBackground(new java.awt.Color(204, 204, 255));
        jLabel1.setFont(new java.awt.Font("Segoe UI", 0, 36)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setText("Sepet Uygulaması");

        UrunSilBtn.setText("Ürünü Sil");

        SepetSilBtn.setText("Sepeti Sil");
        SepetSilBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SepetSilBtnActionPerformed(evt);
            }
        });

        UrunFiyat.setForeground(new java.awt.Color(153, 153, 153));
        UrunFiyat.setText("Urun Fiyati");
        UrunFiyat.setPreferredSize(new java.awt.Dimension(72, 31));
        UrunFiyat.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                UrunFiyatFocusGained(evt);
            }
            public void focusLost(java.awt.event.FocusEvent evt) {
                UrunFiyatFocusLost(evt);
            }
        });
        UrunFiyat.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                UrunFiyatActionPerformed(evt);
            }
        });

        UrunAdi.setForeground(new java.awt.Color(153, 153, 153));
        UrunAdi.setText("Urun Adi");
        UrunAdi.setMaximumSize(new java.awt.Dimension(2147483647, 31));
        UrunAdi.setMinimumSize(new java.awt.Dimension(64, 31));
        UrunAdi.setPreferredSize(new java.awt.Dimension(64, 31));
        UrunAdi.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                UrunAdiFocusGained(evt);
            }
            public void focusLost(java.awt.event.FocusEvent evt) {
                UrunAdiFocusLost(evt);
            }
        });
        UrunAdi.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                UrunAdiActionPerformed(evt);
            }
        });

        UrunEkleBtn.setText("Ürün Ekle");

        UrunAdet.setForeground(new java.awt.Color(153, 153, 153));
        UrunAdet.setText("Urun Adedi");
        UrunAdet.setPreferredSize(new java.awt.Dimension(75, 31));
        UrunAdet.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                UrunAdetFocusGained(evt);
            }
            public void focusLost(java.awt.event.FocusEvent evt) {
                UrunAdetFocusLost(evt);
            }
        });
        UrunAdet.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                UrunAdetActionPerformed(evt);
            }
        });

        SepetEkleBtn.setText("Sepet Ekle");

        Durum.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Akitf", "Tamamlandı", "İptal" }));
        Durum.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                DurumActionPerformed(evt);
            }
        });

        MüsteriAdi.setForeground(new java.awt.Color(153, 153, 153));
        MüsteriAdi.setText("Musteri Adi");
        MüsteriAdi.setToolTipText("");
        MüsteriAdi.setCursor(new java.awt.Cursor(java.awt.Cursor.TEXT_CURSOR));
        MüsteriAdi.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                MüsteriAdiFocusGained(evt);
            }
            public void focusLost(java.awt.event.FocusEvent evt) {
                MüsteriAdiFocusLost(evt);
            }
        });
        MüsteriAdi.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MüsteriAdiActionPerformed(evt);
            }
        });

        jTable2.setBackground(new java.awt.Color(204, 204, 255));
        jTable2.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ID", "Müsteri Adı", "Tarih", "Durum"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jTable2.setGridColor(new java.awt.Color(204, 204, 255));
        jScrollPane1.setViewportView(jTable2);
        if (jTable2.getColumnModel().getColumnCount() > 0) {
            jTable2.getColumnModel().getColumn(0).setResizable(false);
        }

        jTable3.setBackground(new java.awt.Color(204, 204, 255));
        jTable3.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        jTable3.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ID", "Ürün", "Adet", "Fiyat"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane2.setViewportView(jTable3);

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addGap(304, 304, 304)
                .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(289, 289, 289))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGap(365, 365, 365)
                                .addComponent(UrunAdet, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, jPanel1Layout.createSequentialGroup()
                                .addGap(120, 120, 120)
                                .addComponent(MüsteriAdi, javax.swing.GroupLayout.PREFERRED_SIZE, 125, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(59, 59, 59)
                                .addComponent(Durum, javax.swing.GroupLayout.PREFERRED_SIZE, 125, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(72, 72, 72)
                        .addComponent(SepetEkleBtn)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(SepetSilBtn))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(110, 110, 110)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 624, Short.MAX_VALUE)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(UrunAdi, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(UrunFiyat, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(200, 200, 200)
                                .addComponent(UrunEkleBtn)
                                .addGap(18, 18, 18)
                                .addComponent(UrunSilBtn))
                            .addComponent(jScrollPane2))))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(21, 21, 21)
                .addComponent(jLabel1)
                .addGap(64, 64, 64)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(MüsteriAdi, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(Durum, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(SepetEkleBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(SepetSilBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(59, 59, 59)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(UrunAdi, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(UrunFiyat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(UrunAdet, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(UrunEkleBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(UrunSilBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 347, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(86, 86, 86))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 860, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 16, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void UrunAdiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_UrunAdiActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_UrunAdiActionPerformed

    private void UrunAdetActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_UrunAdetActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_UrunAdetActionPerformed

    private void UrunFiyatActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_UrunFiyatActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_UrunFiyatActionPerformed

    private void DurumActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_DurumActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_DurumActionPerformed

    private void MüsteriAdiFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_MüsteriAdiFocusLost
        // TODO add your handling code here:,
        // Eğer kullanıcı hiçbir şey yazmamışsa (kutu boşsa), soluk yazıyı geri getir
if (MüsteriAdi.getText().isEmpty()) {
    MüsteriAdi.setForeground(java.awt.Color.GRAY);
    MüsteriAdi.setText("Musteri Adi");
}
    }//GEN-LAST:event_MüsteriAdiFocusLost

    private void MüsteriAdiFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_MüsteriAdiFocusGained
        // TODO add your handling code here:
        if (MüsteriAdi.getText().equals("Musteri Adi")) {
    MüsteriAdi.setText("");
    MüsteriAdi.setForeground(java.awt.Color.BLACK);
}
    }//GEN-LAST:event_MüsteriAdiFocusGained

    private void SepetSilBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SepetSilBtnActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_SepetSilBtnActionPerformed

    private void MüsteriAdiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MüsteriAdiActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_MüsteriAdiActionPerformed

    private void UrunAdiFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunAdiFocusGained
        // TODO add your handling code here:
        if (UrunAdi.getText().equals("Urun Adi")) {
    UrunAdi.setText("");
    UrunAdi.setForeground(java.awt.Color.BLACK);
}
    }//GEN-LAST:event_UrunAdiFocusGained

    private void UrunAdiFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunAdiFocusLost
        // TODO add your handling code here:
        if (UrunAdi.getText().isEmpty()) {
    UrunAdi.setForeground(java.awt.Color.GRAY);
    UrunAdi.setText("Urun Adi");
}
    }//GEN-LAST:event_UrunAdiFocusLost

    private void UrunFiyatFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunFiyatFocusGained
        // TODO add your handling code here:
        if (UrunFiyat.getText().equals("Urun Fiyati")) {
    UrunFiyat.setText("");
    UrunFiyat.setForeground(java.awt.Color.BLACK);
}
    }//GEN-LAST:event_UrunFiyatFocusGained

    private void UrunFiyatFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunFiyatFocusLost
        // TODO add your handling code here:
        if (UrunFiyat.getText().isEmpty()) {
    UrunFiyat.setForeground(java.awt.Color.GRAY);
    UrunFiyat.setText("Urun Fiyati");
}
    }//GEN-LAST:event_UrunFiyatFocusLost

    private void UrunAdetFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunAdetFocusGained
        // TODO add your handling code here:
        if (UrunAdet.getText().equals("Urun Adedi")) {
    UrunAdet.setText("");
    UrunAdet.setForeground(java.awt.Color.BLACK);
}
        
    }//GEN-LAST:event_UrunAdetFocusGained

    private void UrunAdetFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_UrunAdetFocusLost
        // TODO add your handling code here:
        if (UrunAdet.getText().isEmpty()) {
    UrunAdet.setForeground(java.awt.Color.GRAY);
    UrunAdet.setText("Urun Adedi");
}
    }//GEN-LAST:event_UrunAdetFocusLost

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ReflectiveOperationException | javax.swing.UnsupportedLookAndFeelException ex) {
            logger.log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> new sepet().setVisible(true));
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> Durum;
    private javax.swing.JTextField MüsteriAdi;
    private javax.swing.JButton SepetEkleBtn;
    private javax.swing.JButton SepetSilBtn;
    private javax.swing.JTextField UrunAdet;
    private javax.swing.JTextField UrunAdi;
    private javax.swing.JButton UrunEkleBtn;
    private javax.swing.JTextField UrunFiyat;
    private javax.swing.JButton UrunSilBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable2;
    private javax.swing.JTable jTable3;
    // End of variables declaration//GEN-END:variables
}
