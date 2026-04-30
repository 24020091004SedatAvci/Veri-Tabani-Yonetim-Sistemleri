<?php 
include 'db.php'; 

// URL'den seçili müşteri ID'sini yakala ve sayıya çevir
$seciliMusteri = (isset($_GET['m_id']) && is_numeric($_GET['m_id'])) ? (int)$_GET['m_id'] : null;
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Sepet Uygulaması - Web</title>
    <style>
        /* Tasarımı WinForms ruhuna uygun mor tonlarda hazırladık */
        body { background-color: #6f5fba; color: white; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; text-align: center; margin: 0; padding: 20px; }
        .container { width: 95%; max-width: 1100px; margin: auto; background: #8e82cf; padding: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { margin-bottom: 25px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
        
        /* Tablo Stilleri */
        table { width: 100%; background: white; color: black; border-collapse: collapse; margin-top: 15px; border-radius: 10px; overflow: hidden; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background: #f4f4f4; color: #333; font-weight: bold; }
        
        /* Seçili Satır Efekti (Parlak Sarı) */
        tr.selected { background-color: #ffff00 !important; color: black !important; font-weight: bold; }
        tr:hover { background-color: #f1f1f1; cursor: pointer; }
        
        /* Form ve Butonlar */
        .form-area { background: rgba(255,255,255,0.15); padding: 20px; border-radius: 10px; margin-bottom: 25px; }
        input, select, button { padding: 10px; margin: 5px; border-radius: 6px; border: 1px solid #ccc; font-size: 14px; }
        .btn-m-ekle { background: #4CAF50; color: white; border: none; cursor: pointer; font-weight: bold; }
        .btn-u-ekle { background: #2196F3; color: white; border: none; cursor: pointer; font-weight: bold; }
        .btn-m-ekle:hover, .btn-u-ekle:hover { opacity: 0.8; }
        .link-sil { color: #d32f2f; text-decoration: none; font-weight: bold; }
        
        /* Durum Renkleri */
        .status-aktif { color: #2196F3; font-weight: bold; }
        .status-iptal { color: #f44336; font-weight: bold; }
        .status-tamam { color: #2e7d32; font-weight: bold; }
    </style>
</head>
<body>

    <div class="container">
        <h1>Sepet Uygulaması</h1>

        <!-- MÜŞTERİ EKLEME FORMU -->
        <div class="form-area">
            <form action="islem.php" method="POST">
                <input type="text" name="m_adi" placeholder="Müşteri Adı" required>
                <select name="durum">
                    <option value="Aktif">Aktif</option>
                    <option value="İptal">İptal</option>
                    <option value="Tamamlandı">Tamamlandı</option>
                </select>
                <button type="submit" name="m_ekle" class="btn-m-ekle">Müşteriyi Sepete Ekle</button>
            </form>
        </div>

        <!-- MÜŞTERİ TABLOSU -->
        <table>
            <thead>
                <tr>
                    <th>Müşteri ID</th>
                    <th>Müşteri Adı</th>
                    <th>Kayıt Tarihi</th>
                    <th>Durum</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $sorgu = sqlsrv_query($conn, "SELECT * FROM müsteri");
                while($row = sqlsrv_fetch_array($sorgu, SQLSRV_FETCH_ASSOC)):
                    $m_id = $row['müsteri_id'];
                    $seciliMi = ($seciliMusteri === $m_id);
                    
                    // Duruma göre CSS sınıfı belirleme
                    $durumClass = "";
                    if($row['durum'] == "Aktif") $durumClass = "status-aktif";
                    elseif($row['durum'] == "İptal") $durumClass = "status-iptal";
                    elseif($row['durum'] == "Tamamlandı") $durumClass = "status-tamam";
                ?>
                <tr class="<?php echo $seciliMi ? 'selected' : ''; ?>" onclick="location.href='index.php?m_id=<?php echo $m_id; ?>'">
                    <td><?php echo $m_id; ?></td>
                    <td><?php echo $row['müsteri_adi']; ?></td>
                    <td><?php echo ($row['tarih'] ? $row['tarih']->format('d.m.Y H:i') : ''); ?></td>
                    <td class="<?php echo $durumClass; ?>"><?php echo $row['durum']; ?></td>
                    <td>
                        <a href="islem.php?m_sil=<?php echo $m_id; ?>" class="link-sil" onclick="event.stopPropagation(); return confirm('Bu müşteriyi ve tüm sepetini silmek istediğine emin misin?');">Sil</a>
                    </td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>

        <br><hr style="border: 0.5px solid rgba(255,255,255,0.3);"><br>

        <!-- ÜRÜN (SEPET) DETAY BÖLÜMÜ -->
        <?php if($seciliMusteri): ?>
            <h2 style="text-align: left; margin-left: 10px;">Seçili Müşteri Sepeti (ID: <?php echo $seciliMusteri; ?>)</h2>
            <div class="form-area">
                <form action="islem.php" method="POST">
                    <input type="hidden" name="m_id" value="<?php echo $seciliMusteri; ?>">
                    <input type="text" name="u_adi" placeholder="Ürün Adı" required>
                    <input type="number" name="u_fiyat" placeholder="Fiyat (TL)" step="0.01" required>
                    <input type="number" name="u_adet" placeholder="Adet" required>
                    <button type="submit" name="u_ekle" class="btn-u-ekle">Ürünü Sepete At</button>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Ürün No</th>
                        <th>Ürün İsmi</th>
                        <th>Birim Fiyat</th>
                        <th>Miktar</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $u_sorgu = sqlsrv_query($conn, "SELECT * FROM sepet WHERE müsteri_id = ?", array($seciliMusteri));
                    while($u_row = sqlsrv_fetch_array($u_sorgu, SQLSRV_FETCH_ASSOC)):
                    ?>
                    <tr>
                        <td><?php echo $u_row['ürün_id']; ?></td>
                        <td><?php echo $u_row['ürün_adi']; ?></td>
                        <td><?php echo number_format($u_row['fiyat'], 2); ?> TL</td>
                        <td><?php echo $u_row['adet']; ?></td>
                        <td>
                            <a href="islem.php?u_sil=<?php echo $u_row['ürün_id']; ?>&m_id=<?php echo $seciliMusteri; ?>" class="link-sil">Sil</a>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p style="font-style: italic; opacity: 0.8; margin-top: 20px;">Sepet içeriğini yönetmek için listeden bir müşterinin üzerine tıklayın.</p>
        <?php endif; ?>

    </div>

</body>
</html>