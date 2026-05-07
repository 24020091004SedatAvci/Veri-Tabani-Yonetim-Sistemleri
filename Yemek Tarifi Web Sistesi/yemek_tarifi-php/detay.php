<?php
include "baglanti.php";

if (!isset($_GET["id"])) {
    header("Location: index.php");
    exit;
}

$id = $_GET["id"];

$stmt = $db->prepare("
    SELECT tarifler.*, kategoriler.kategori_adi
    FROM tarifler
    INNER JOIN kategoriler ON tarifler.kategori_id = kategoriler.id
    WHERE tarifler.id = ?
");

$stmt->execute([$id]);
$tarif = $stmt->fetch();

if (!$tarif) {
    header("Location: index.php");
    exit;
}

$malzemeler = $db->prepare("
    SELECT malzemeler.malzeme_adi, tarif_malzemeleri.miktar
    FROM tarif_malzemeleri
    INNER JOIN malzemeler ON tarif_malzemeleri.malzeme_id = malzemeler.id
    WHERE tarif_malzemeleri.tarif_id = ?
");

$malzemeler->execute([$id]);
$malzemeListesi = $malzemeler->fetchAll();
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Detay</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
    <h1>Tarif Detay</h1>
    <p>Seçilen tarifin bilgileri ve alışveriş listesi.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title"><?php echo htmlspecialchars($tarif["tarif_adi"]); ?></h2>

        <div>
            <a href="index.php" class="btn btn-secondary">Ana Sayfa</a>
            <a href="tarif_crud.php" class="btn">Tarif Listesi</a>
        </div>
    </div>

    <div class="detail-card">
        <img src="<?php echo htmlspecialchars($tarif["fotograf_url"]); ?>" alt="Yemek Fotoğrafı">

        <div class="detail-content">
            <span class="badge"><?php echo htmlspecialchars($tarif["kategori_adi"]); ?></span>

            <h2><?php echo htmlspecialchars($tarif["tarif_adi"]); ?></h2>

            <p><b>Hazırlama Süresi:</b> <?php echo htmlspecialchars($tarif["hazirlama_suresi"]); ?> dakika</p>

            <p><b>Tarif Açıklaması:</b></p>
            <p><?php echo nl2br(htmlspecialchars($tarif["aciklama"])); ?></p>
        </div>
    </div>

    <h2 class="section-title">Alışveriş Listesi</h2>

    <?php if (count($malzemeListesi) > 0) { ?>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>Malzeme</th>
                    <th>Miktar</th>
                </tr>

                <?php foreach ($malzemeListesi as $m) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($m["malzeme_adi"]); ?></td>
                        <td><?php echo htmlspecialchars($m["miktar"]); ?></td>
                    </tr>
                <?php } ?>
            </table>
        </div>
    <?php } else { ?>
        <div class="empty-message">
            Bu tarife ait malzeme eklenmemiş.
        </div>
    <?php } ?>

    <div class="footer-note">
        Yemek Tarifi Web Sitesi - Tarif Detay Ekranı
    </div>

</div>

</body>
</html>