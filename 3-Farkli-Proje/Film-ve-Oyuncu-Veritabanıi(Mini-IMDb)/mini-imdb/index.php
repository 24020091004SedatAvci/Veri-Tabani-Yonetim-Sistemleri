<?php
require_once "baglanti.php";

$sqlFilmler = "
SELECT 
    filmler.id,
    filmler.film_adi,
    filmler.yayin_yili,
    filmler.poster_url,
    filmler.puan,
    turler.id AS tur_id,
    turler.tur_adi
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
ORDER BY filmler.id DESC
";

$filmler = $conn->query($sqlFilmler)->fetchAll(PDO::FETCH_ASSOC);

$turler = $conn->query("
SELECT * FROM turler 
ORDER BY tur_adi ASC
")->fetchAll(PDO::FETCH_ASSOC);

$sqlOyuncular = "
SELECT 
    oyuncular.id,
    oyuncular.oyuncu_adi,
    oyuncular.foto_url,
    COUNT(film_oyunculari.id) AS film_sayisi
FROM oyuncular
LEFT JOIN film_oyunculari ON oyuncular.id = film_oyunculari.oyuncu_id
GROUP BY oyuncular.id, oyuncular.oyuncu_adi, oyuncular.foto_url
ORDER BY film_sayisi DESC, oyuncular.id DESC
LIMIT 6
";

$oyuncular = $conn->query($sqlOyuncular)->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Mini IMDb - Film Vitrini</title>
    <link rel="stylesheet" href="style.css?v=4">
</head>
<body>

<header class="navbar">
    <div class="logo">Mini IMDb</div>

    <nav>
        <a href="index.php">Filmler</a>
        <a href="film-yonetim.php">Film Yönetimi</a>
        <a href="film-ekle.php">Film Ekle</a>
    </nav>
</header>

<section class="hero">
    <div>
        <h1>Sinema Arşivini Keşfet</h1>
        <p>Filmleri, oyuncu kadrolarını, yönetmenleri ve türleri modern bir Mini IMDb sistemiyle görüntüle.</p>
    </div>
</section>

<section class="container">

    <div class="featured-actors">
        <div class="section-title">
            <h2>Öne Çıkan Oyuncular</h2>
            <p>Film arşivindeki oyuncuları profilleri ve oynadıkları filmlerle birlikte incele.</p>
        </div>

        <div class="actor-showcase">
            <?php if (count($oyuncular) > 0): ?>
                <?php foreach ($oyuncular as $oyuncu): ?>
                    <a href="oyuncu-profil.php?actorId=<?= $oyuncu['id'] ?>" class="actor-showcase-card">
                        <img 
                            src="<?= htmlspecialchars($oyuncu['foto_url']) ?>" 
                            alt="<?= htmlspecialchars($oyuncu['oyuncu_adi']) ?>"
                            onerror="this.src='https://via.placeholder.com/300x300?text=Oyuncu';"
                        >

                        <h3><?= htmlspecialchars($oyuncu['oyuncu_adi']) ?></h3>
                        <p><?= htmlspecialchars($oyuncu['film_sayisi']) ?> filmde yer aldı</p>

                        <span>Profili Gör</span>
                    </a>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="empty-box">Henüz oyuncu kaydı bulunamadı.</div>
            <?php endif; ?>
        </div>
    </div>

    <div class="section-title">
        <h2>Film Vitrini</h2>
        <p>Tüm filmler posterleri ve kısa bilgileriyle listelenir.</p>
    </div>

    <div class="category-bar">
        <a href="index.php" class="category-link active">Tümü</a>

        <?php foreach ($turler as $tur): ?>
            <a href="kategori.php?genreId=<?= $tur['id'] ?>" class="category-link">
                <?= htmlspecialchars($tur['tur_adi']) ?>
            </a>
        <?php endforeach; ?>
    </div>

    <div class="movie-grid">
        <?php if (count($filmler) > 0): ?>
            <?php foreach ($filmler as $film): ?>
                <div class="movie-card">
                    <div class="poster-area">
                        <img 
                            src="<?= htmlspecialchars($film['poster_url']) ?>" 
                            alt="<?= htmlspecialchars($film['film_adi']) ?>"
                            onerror="this.src='https://via.placeholder.com/400x600?text=Poster+Yok';"
                        >

                        <span class="rating">★ <?= htmlspecialchars($film['puan']) ?></span>
                    </div>

                    <div class="movie-content">
                        <h3><?= htmlspecialchars($film['film_adi']) ?></h3>

                        <div class="movie-meta">
                            <span><?= htmlspecialchars($film['yayin_yili']) ?></span>
                            <span><?= htmlspecialchars($film['tur_adi']) ?></span>
                        </div>

                        <div class="card-buttons">
                            <a href="film-detay.php?movieId=<?= $film['id'] ?>" class="btn primary">Detay</a>
                            <a href="kategori.php?genreId=<?= $film['tur_id'] ?>" class="btn ghost">Kategori</a>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="empty-box">Henüz film kaydı bulunamadı.</div>
        <?php endif; ?>
    </div>

</section>

</body>
</html>