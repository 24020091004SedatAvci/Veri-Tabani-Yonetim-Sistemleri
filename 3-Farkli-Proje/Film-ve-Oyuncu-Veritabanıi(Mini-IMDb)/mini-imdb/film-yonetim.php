<?php
require_once "baglanti.php";

$sqlFilmler = "
SELECT 
    filmler.id,
    filmler.film_adi,
    filmler.yayin_yili,
    filmler.puan,
    turler.tur_adi,
    yonetmenler.ad_soyad AS yonetmen_adi
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
INNER JOIN yonetmenler ON filmler.yonetmen_id = yonetmenler.id
ORDER BY filmler.id DESC
";

$filmler = $conn->query($sqlFilmler)->fetchAll(PDO::FETCH_ASSOC);

$mesaj = $_GET["mesaj"] ?? "";
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Film Yönetimi</title>
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

    <div class="page-head">
        <div class="section-title">
            <h2>Film Yönetimi</h2>
            <p>Filmleri düzenleyebilir, silebilir veya yeni film ekleyebilirsin.</p>
        </div>

        <a href="film-ekle.php" class="btn primary">+ Yeni Film Ekle</a>
    </div>

    <?php if ($mesaj == "guncellendi"): ?>
        <div class="alert success">Film başarıyla güncellendi.</div>
    <?php elseif ($mesaj == "silindi"): ?>
        <div class="alert danger">Film başarıyla silindi.</div>
    <?php elseif ($mesaj == "eklendi"): ?>
        <div class="alert success">Film ve oyuncu bilgileri başarıyla eklendi.</div>
    <?php endif; ?>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Film Adı</th>
                    <th>Yıl</th>
                    <th>Tür</th>
                    <th>Yönetmen</th>
                    <th>Puan</th>
                    <th>İşlem</th>
                </tr>
            </thead>

            <tbody>
                <?php if (count($filmler) > 0): ?>
                    <?php foreach ($filmler as $film): ?>
                        <tr>
                            <td><?= htmlspecialchars($film["id"]) ?></td>
                            <td><?= htmlspecialchars($film["film_adi"]) ?></td>
                            <td><?= htmlspecialchars($film["yayin_yili"]) ?></td>
                            <td><?= htmlspecialchars($film["tur_adi"]) ?></td>
                            <td><?= htmlspecialchars($film["yonetmen_adi"]) ?></td>
                            <td>★ <?= htmlspecialchars($film["puan"]) ?></td>
                            <td class="actions">
                                <a href="film-duzenle.php?id=<?= $film["id"] ?>" class="btn small primary">
                                    Düzenle
                                </a>

                                <a 
                                    href="film-sil.php?id=<?= $film["id"] ?>" 
                                    class="btn small danger"
                                    onclick="return confirm('Bu filmi silmek istediğine emin misin?');"
                                >
                                    Sil
                                </a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="7">Henüz film kaydı bulunamadı.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

</section>

</body>
</html>