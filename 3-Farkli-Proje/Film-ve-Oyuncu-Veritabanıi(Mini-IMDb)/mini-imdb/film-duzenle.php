<?php
require_once "baglanti.php";

if (!isset($_GET["id"]) || !is_numeric($_GET["id"])) {
    header("Location: film-yonetim.php");
    exit;
}

$id = intval($_GET["id"]);

$stmtFilm = $conn->prepare("SELECT * FROM filmler WHERE id = ?");
$stmtFilm->execute([$id]);
$film = $stmtFilm->fetch(PDO::FETCH_ASSOC);

if (!$film) {
    header("Location: film-yonetim.php");
    exit;
}

$turler = $conn->query("
SELECT * FROM turler 
ORDER BY tur_adi ASC
")->fetchAll(PDO::FETCH_ASSOC);

$yonetmenler = $conn->query("
SELECT * FROM yonetmenler 
ORDER BY ad_soyad ASC
")->fetchAll(PDO::FETCH_ASSOC);

$oyuncular = $conn->query("
SELECT * FROM oyuncular 
ORDER BY oyuncu_adi ASC
")->fetchAll(PDO::FETCH_ASSOC);

$stmtCast = $conn->prepare("
SELECT oyuncu_id, rol_adi 
FROM film_oyunculari 
WHERE film_id = ?
ORDER BY id ASC
LIMIT 5
");

$stmtCast->execute([$id]);
$mevcutCast = $stmtCast->fetchAll(PDO::FETCH_ASSOC);

$hata = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $film_adi = trim($_POST["film_adi"]);
    $yayin_yili = intval($_POST["yayin_yili"]);
    $tur_id = intval($_POST["tur_id"]);
    $yonetmen_id = intval($_POST["yonetmen_id"]);
    $ozet = trim($_POST["ozet"]);
    $poster_url = trim($_POST["poster_url"]);
    $sure_dk = intval($_POST["sure_dk"]);
    $puan = floatval($_POST["puan"]);

    $secili_oyuncular = $_POST["oyuncu_id"] ?? [];
    $rol_adlari = $_POST["rol_adi"] ?? [];

    if ($film_adi == "" || $yayin_yili <= 0 || $tur_id <= 0 || $yonetmen_id <= 0) {
        $hata = "Lütfen film adı, yayın yılı, tür ve yönetmen alanlarını doldur.";
    } else {
        try {
            $conn->beginTransaction();

            $sqlUpdate = "
            UPDATE filmler
            SET 
                film_adi = ?,
                yayin_yili = ?,
                tur_id = ?,
                yonetmen_id = ?,
                ozet = ?,
                poster_url = ?,
                sure_dk = ?,
                puan = ?
            WHERE id = ?
            ";

            $stmtUpdate = $conn->prepare($sqlUpdate);
            $stmtUpdate->execute([
                $film_adi,
                $yayin_yili,
                $tur_id,
                $yonetmen_id,
                $ozet,
                $poster_url,
                $sure_dk,
                $puan,
                $id
            ]);

            $stmtDeleteCast = $conn->prepare("
            DELETE FROM film_oyunculari 
            WHERE film_id = ?
            ");

            $stmtDeleteCast->execute([$id]);

            $stmtInsertCast = $conn->prepare("
            INSERT INTO film_oyunculari 
            (film_id, oyuncu_id, rol_adi)
            VALUES (?, ?, ?)
            ");

            for ($i = 0; $i < count($secili_oyuncular); $i++) {
                $oyuncu_id = intval($secili_oyuncular[$i]);
                $rol_adi = trim($rol_adlari[$i] ?? "");

                if ($oyuncu_id > 0 && $rol_adi != "") {
                    $stmtInsertCast->execute([$id, $oyuncu_id, $rol_adi]);
                }
            }

            $conn->commit();

            header("Location: film-yonetim.php?mesaj=guncellendi");
            exit;

        } catch (Exception $e) {
            $conn->rollBack();
            $hata = "Film güncellenirken hata oluştu: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Film Düzenle</title>
    <link rel="stylesheet" href="style.css?v=3">
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
        <h2>Film Düzenle</h2>
        <p>Film bilgilerini ve oyuncu kadrosunu güncelle.</p>
    </div>

    <?php if ($hata): ?>
        <div class="alert danger"><?= htmlspecialchars($hata) ?></div>
    <?php endif; ?>

    <form method="POST" class="form-card">

        <div class="form-section-title">
            <h3>Film Bilgileri</h3>
            <p>Seçili filmin temel bilgilerini düzenle.</p>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Film Adı</label>
                <input 
                    type="text" 
                    name="film_adi" 
                    value="<?= htmlspecialchars($film["film_adi"]) ?>" 
                    required
                >
            </div>

            <div class="form-group">
                <label>Yayın Yılı</label>
                <input 
                    type="number" 
                    name="yayin_yili" 
                    value="<?= htmlspecialchars($film["yayin_yili"]) ?>" 
                    required
                >
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Tür</label>

                <select name="tur_id" required>
                    <?php foreach ($turler as $tur): ?>
                        <option 
                            value="<?= $tur["id"] ?>" 
                            <?= $tur["id"] == $film["tur_id"] ? "selected" : "" ?>
                        >
                            <?= htmlspecialchars($tur["tur_adi"]) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label>Yönetmen</label>

                <select name="yonetmen_id" required>
                    <?php foreach ($yonetmenler as $yonetmen): ?>
                        <option 
                            value="<?= $yonetmen["id"] ?>" 
                            <?= $yonetmen["id"] == $film["yonetmen_id"] ? "selected" : "" ?>
                        >
                            <?= htmlspecialchars($yonetmen["ad_soyad"]) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Süre DK</label>
                <input 
                    type="number" 
                    name="sure_dk" 
                    value="<?= htmlspecialchars($film["sure_dk"]) ?>"
                >
            </div>

            <div class="form-group">
                <label>Puan</label>
                <input 
                    type="number" 
                    step="0.1" 
                    min="0" 
                    max="10" 
                    name="puan" 
                    value="<?= htmlspecialchars($film["puan"]) ?>"
                >
            </div>
        </div>

        <div class="form-group">
            <label>Poster URL</label>
            <input 
                type="text" 
                name="poster_url" 
                value="<?= htmlspecialchars($film["poster_url"]) ?>"
            >
        </div>

        <div class="form-group">
            <label>Özet</label>
            <textarea name="ozet" rows="5"><?= htmlspecialchars($film["ozet"]) ?></textarea>
        </div>

        <div class="form-section-title">
            <h3>Oyuncu Kadrosu</h3>
            <p>Oyuncuları ve filmdeki rollerini düzenle.</p>
        </div>

        <div class="cast-box">
            <?php for ($i = 0; $i < 5; $i++): ?>
                <?php
                    $castOyuncuId = $mevcutCast[$i]["oyuncu_id"] ?? 0;
                    $castRolAdi = $mevcutCast[$i]["rol_adi"] ?? "";
                ?>

                <div class="cast-row">
                    <div class="form-group">
                        <label>Oyuncu <?= $i + 1 ?></label>

                        <select name="oyuncu_id[]">
                            <option value="0">Oyuncu Seç</option>

                            <?php foreach ($oyuncular as $oyuncu): ?>
                                <option 
                                    value="<?= $oyuncu["id"] ?>" 
                                    <?= $oyuncu["id"] == $castOyuncuId ? "selected" : "" ?>
                                >
                                    <?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Rol Adı</label>
                        <input 
                            type="text" 
                            name="rol_adi[]" 
                            value="<?= htmlspecialchars($castRolAdi) ?>" 
                            placeholder="Örn: Dom Cobb"
                        >
                    </div>
                </div>
            <?php endfor; ?>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn primary">Güncelle</button>
            <a href="film-yonetim.php" class="btn ghost">Vazgeç</a>
        </div>

    </form>

</section>

</body>
</html>