<?php
require_once "baglanti.php";

if (!isset($_GET["movieId"]) || !is_numeric($_GET["movieId"])) {
    header("Location: index.php");
    exit;
}

$movieId = intval($_GET["movieId"]);

$sqlFilm = "
SELECT 
    filmler.*,
    turler.tur_adi,
    yonetmenler.ad_soyad AS yonetmen_adi,
    yonetmenler.deneyim_yili,
    yonetmenler.biyografi AS yonetmen_biyografi
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
INNER JOIN yonetmenler ON filmler.yonetmen_id = yonetmenler.id
WHERE filmler.id = ?
";

$stmtFilm = $conn->prepare($sqlFilm);
$stmtFilm->execute([$movieId]);
$film = $stmtFilm->fetch(PDO::FETCH_ASSOC);

if (!$film) {
    header("Location: index.php");
    exit;
}

$sqlOyuncular = "
SELECT 
    oyuncular.id,
    oyuncular.oyuncu_adi,
    oyuncular.foto_url,
    film_oyunculari.rol_adi
FROM film_oyunculari
INNER JOIN oyuncular ON film_oyunculari.oyuncu_id = oyuncular.id
WHERE film_oyunculari.film_id = ?
ORDER BY oyuncular.oyuncu_adi ASC
";

$stmtOyuncular = $conn->prepare($sqlOyuncular);
$stmtOyuncular->execute([$movieId]);
$oyuncular = $stmtOyuncular->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($film["film_adi"]) ?> - Film Detay</title>
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

    <div class="detail-card">
        <div class="detail-poster">
            <img 
                src="<?= htmlspecialchars($film["poster_url"]) ?>" 
                alt="<?= htmlspecialchars($film["film_adi"]) ?>"
                onerror="this.src='https://via.placeholder.com/400x600?text=Poster+Yok';"
            >
        </div>

        <div class="detail-info">
            <span class="tag"><?= htmlspecialchars($film["tur_adi"]) ?></span>

            <h1><?= htmlspecialchars($film["film_adi"]) ?></h1>

            <div class="detail-meta">
                <span><?= htmlspecialchars($film["yayin_yili"]) ?></span>
                <span><?= htmlspecialchars($film["sure_dk"]) ?> dk</span>
                <span>★ <?= htmlspecialchars($film["puan"]) ?></span>
            </div>

            <p class="summary">
                <?= nl2br(htmlspecialchars($film["ozet"])) ?>
            </p>

            <div class="info-list">
                <p><strong>Yönetmen:</strong> <?= htmlspecialchars($film["yonetmen_adi"]) ?></p>
                <p><strong>Deneyim:</strong> <?= htmlspecialchars($film["deneyim_yili"]) ?> yıl</p>
            </div>

            <a href="index.php" class="btn ghost">Geri Dön</a>
        </div>
    </div>

    <div class="section-title">
        <h2>Oyuncu Kadrosu</h2>
        <p>Filmde yer alan oyuncular ve rol adları.</p>
    </div>

    <div class="actor-grid">
        <?php if (count($oyuncular) > 0): ?>
            <?php foreach ($oyuncular as $oyuncu): ?>
                <a href="oyuncu-profil.php?actorId=<?= $oyuncu["id"] ?>" class="actor-card">
                    <img 
                        src="<?= htmlspecialchars($oyuncu["foto_url"]) ?>" 
                        alt="<?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?>"
                        onerror="this.src='https://via.placeholder.com/300x300?text=Oyuncu';"
                    >

                    <div>
                        <h3><?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?></h3>
                        <p><?= htmlspecialchars($oyuncu["rol_adi"]) ?></p>
                    </div>
                </a>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="empty-box">Bu filme ait oyuncu kaydı bulunamadı.</div>
        <?php endif; ?>
    </div>

</section>

</body>
</html>