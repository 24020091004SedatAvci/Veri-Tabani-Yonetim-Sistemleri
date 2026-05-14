<?php
require_once "baglanti.php";

if (!isset($_GET["genreId"]) || !is_numeric($_GET["genreId"])) {
    header("Location: index.php");
    exit;
}

$genreId = intval($_GET["genreId"]);

$stmtTur = $conn->prepare("SELECT * FROM turler WHERE id = ?");
$stmtTur->execute([$genreId]);
$tur = $stmtTur->fetch(PDO::FETCH_ASSOC);

if (!$tur) {
    header("Location: index.php");
    exit;
}

$sqlFilmler = "
SELECT 
    filmler.id,
    filmler.film_adi,
    filmler.yayin_yili,
    filmler.poster_url,
    filmler.puan,
    turler.tur_adi
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
WHERE turler.id = ?
ORDER BY filmler.yayin_yili DESC
";

$stmtFilmler = $conn->prepare($sqlFilmler);
$stmtFilmler->execute([$genreId]);
$filmler = $stmtFilmler->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($tur["tur_adi"]) ?> Filmleri</title>
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

<section class="container">

    <div class="section-title">
        <h2><?= htmlspecialchars($tur["tur_adi"]) ?> Filmleri</h2>
        <p>Seçilen kategoriye ait filmler listeleniyor.</p>
    </div>

    <a href="index.php" class="btn ghost">Tüm Filmlere Dön</a>

    <div class="movie-grid top-space">
        <?php if (count($filmler) > 0): ?>
            <?php foreach ($filmler as $film): ?>
                <div class="movie-card">
                    <div class="poster-area">
                        <img 
                            src="<?= htmlspecialchars($film["poster_url"]) ?>" 
                            alt="<?= htmlspecialchars($film["film_adi"]) ?>"
                            onerror="this.src='https://via.placeholder.com/400x600?text=Poster+Yok';"
                        >

                        <span class="rating">★ <?= htmlspecialchars($film["puan"]) ?></span>
                    </div>

                    <div class="movie-content">
                        <h3><?= htmlspecialchars($film["film_adi"]) ?></h3>

                        <div class="movie-meta">
                            <span><?= htmlspecialchars($film["yayin_yili"]) ?></span>
                            <span><?= htmlspecialchars($film["tur_adi"]) ?></span>
                        </div>

                        <a href="film-detay.php?movieId=<?= $film["id"] ?>" class="btn primary full">
                            Detay
                        </a>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="empty-box">Bu kategoriye ait film bulunamadı.</div>
        <?php endif; ?>
    </div>

</section>

</body>
</html>