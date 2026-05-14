<?php
require_once "baglanti.php";

if (!isset($_GET["actorId"]) || !is_numeric($_GET["actorId"])) {
    header("Location: index.php");
    exit;
}

$actorId = intval($_GET["actorId"]);

$stmtOyuncu = $conn->prepare("SELECT * FROM oyuncular WHERE id = ?");
$stmtOyuncu->execute([$actorId]);
$oyuncu = $stmtOyuncu->fetch(PDO::FETCH_ASSOC);

if (!$oyuncu) {
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
    turler.tur_adi,
    film_oyunculari.rol_adi
FROM film_oyunculari
INNER JOIN filmler ON film_oyunculari.film_id = filmler.id
INNER JOIN turler ON filmler.tur_id = turler.id
WHERE film_oyunculari.oyuncu_id = ?
ORDER BY filmler.yayin_yili DESC
";

$stmtFilmler = $conn->prepare($sqlFilmler);
$stmtFilmler->execute([$actorId]);
$filmler = $stmtFilmler->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?> - Oyuncu Profili</title>
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

    <div class="profile-card">
        <img 
            src="<?= htmlspecialchars($oyuncu["foto_url"]) ?>" 
            alt="<?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?>"
            onerror="this.src='https://via.placeholder.com/300x300?text=Oyuncu';"
        >

        <div>
            <span class="tag">Oyuncu Profili</span>

            <h1><?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?></h1>

            <p><strong>Doğum Tarihi:</strong> <?= htmlspecialchars($oyuncu["dogum_tarihi"]) ?></p>

            <p class="summary">
                <?= nl2br(htmlspecialchars($oyuncu["biyografi"])) ?>
            </p>

            <a href="index.php" class="btn ghost">Geri Dön</a>
        </div>
    </div>

    <div class="section-title">
        <h2>Oynadığı Filmler</h2>
        <p>Oyuncunun yer aldığı filmler ve filmdeki rol bilgileri.</p>
    </div>

    <div class="movie-grid small-grid">
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

                        <p class="summary">
                            Rol: <?= htmlspecialchars($film["rol_adi"]) ?>
                        </p>

                        <a href="film-detay.php?movieId=<?= $film["id"] ?>" class="btn primary full">
                            Filme Git
                        </a>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="empty-box">Bu oyuncuya ait film kaydı bulunamadı.</div>
        <?php endif; ?>
    </div>

</section>

</body>
</html>