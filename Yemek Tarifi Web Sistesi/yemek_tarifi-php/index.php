<?php include "baglanti.php"; ?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Yemek Tarifleri</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
    <h1>Yemek Tarifleri</h1>
    <p>Lezzetli tarifleri keşfet, yeni tarif ekle ve alışveriş listeni oluştur.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title">Yemek Listesi</h2>
        <a href="tarif_crud.php" class="btn">+ Yeni Tarif Ekle</a>
    </div>

    <div class="card-list">
        <?php
        $sorgu = $db->query("
            SELECT tarifler.*, kategoriler.kategori_adi 
            FROM tarifler 
            INNER JOIN kategoriler ON tarifler.kategori_id = kategoriler.id
            ORDER BY tarifler.id DESC
        ");

        $tarifVarMi = false;

        foreach ($sorgu as $tarif) {
            $tarifVarMi = true;
        ?>
            <div class="card">
                <img src="<?php echo htmlspecialchars($tarif['fotograf_url']); ?>" alt="Yemek Fotoğrafı">

                <div class="card-body">
                    <span class="badge"><?php echo htmlspecialchars($tarif['kategori_adi']); ?></span>

                    <h3><?php echo htmlspecialchars($tarif['tarif_adi']); ?></h3>

                    <p><b>Hazırlama Süresi:</b> <?php echo htmlspecialchars($tarif['hazirlama_suresi']); ?> dk</p>

                    <a class="btn" href="detay.php?id=<?php echo $tarif['id']; ?>">
                        Detay Gör
                    </a>
                </div>
            </div>
        <?php } ?>
    </div>

    <?php if (!$tarifVarMi) { ?>
        <div class="empty-message">
            Henüz tarif eklenmemiş. İlk tarifi eklemek için “Yeni Tarif Ekle” butonuna bas.
        </div>
    <?php } ?>

    <div class="footer-note">
        Yemek Tarifi Web Sitesi
    </div>

</div>

</body>
</html>