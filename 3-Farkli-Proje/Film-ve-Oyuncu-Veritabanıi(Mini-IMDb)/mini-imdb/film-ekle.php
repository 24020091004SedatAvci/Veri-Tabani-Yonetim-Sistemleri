<?php
require_once "baglanti.php";

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

            $sqlFilm = "
            INSERT INTO filmler 
            (film_adi, yayin_yili, tur_id, yonetmen_id, ozet, poster_url, sure_dk, puan)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ";

            $stmtFilm = $conn->prepare($sqlFilm);
            $stmtFilm->execute([
                $film_adi,
                $yayin_yili,
                $tur_id,
                $yonetmen_id,
                $ozet,
                $poster_url,
                $sure_dk,
                $puan
            ]);

            $film_id = $conn->lastInsertId();

            $sqlCast = "
            INSERT INTO film_oyunculari 
            (film_id, oyuncu_id, rol_adi)
            VALUES (?, ?, ?)
            ";

            $stmtCast = $conn->prepare($sqlCast);

            for ($i = 0; $i < count($secili_oyuncular); $i++) {
                $oyuncu_id = intval($secili_oyuncular[$i]);
                $rol_adi = trim($rol_adlari[$i] ?? "");

                if ($oyuncu_id > 0 && $rol_adi != "") {
                    $stmtCast->execute([$film_id, $oyuncu_id, $rol_adi]);
                }
            }

            $conn->commit();

            header("Location: film-yonetim.php?mesaj=eklendi");
            exit;

        } catch (Exception $e) {
            $conn->rollBack();
            $hata = "Film eklenirken hata oluştu: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Yeni Film Ekle</title>
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
        <h2>Yeni Film Ekle</h2>
        <p>Film bilgilerini gir, ardından oyuncuları ve rollerini aynı ekrandan ata.</p>
    </div>

    <?php if ($hata): ?>
        <div class="alert danger"><?= htmlspecialchars($hata) ?></div>
    <?php endif; ?>

    <form method="POST" class="form-card">

        <div class="form-section-title">
            <h3>Film Bilgileri</h3>
            <p>Filmin temel bilgilerini doldur.</p>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Film Adı</label>
                <input type="text" name="film_adi" required>
            </div>

            <div class="form-group">
                <label>Yayın Yılı</label>
                <input type="number" name="yayin_yili" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Tür</label>
                <select name="tur_id" required>
                    <option value="">Tür Seç</option>

                    <?php foreach ($turler as $tur): ?>
                        <option value="<?= $tur["id"] ?>">
                            <?= htmlspecialchars($tur["tur_adi"]) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label>Yönetmen</label>
                <select name="yonetmen_id" required>
                    <option value="">Yönetmen Seç</option>

                    <?php foreach ($yonetmenler as $yonetmen): ?>
                        <option value="<?= $yonetmen["id"] ?>">
                            <?= htmlspecialchars($yonetmen["ad_soyad"]) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Süre DK</label>
                <input type="number" name="sure_dk" placeholder="Örn: 148">
            </div>

            <div class="form-group">
                <label>Puan</label>
                <input type="number" name="puan" step="0.1" min="0" max="10" placeholder="Örn: 8.7">
            </div>
        </div>

        <div class="form-group">
            <label>Poster URL</label>
            <input type="text" name="poster_url" placeholder="Film poster linki">
        </div>

        <div class="form-group">
            <label>Özet</label>
            <textarea name="ozet" rows="5" placeholder="Film konusu..."></textarea>
        </div>

        <div class="form-section-title">
            <h3>Oyuncu Kadrosu</h3>
            <p>Filmde oynayan oyuncuları seç ve filmdeki rol adlarını yaz.</p>
        </div>

        <div class="cast-box">
            <?php for ($i = 0; $i < 5; $i++): ?>
                <div class="cast-row">
                    <div class="form-group">
                        <label>Oyuncu <?= $i + 1 ?></label>

                        <select name="oyuncu_id[]">
                            <option value="0">Oyuncu Seç</option>

                            <?php foreach ($oyuncular as $oyuncu): ?>
                                <option value="<?= $oyuncu["id"] ?>">
                                    <?= htmlspecialchars($oyuncu["oyuncu_adi"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Rol Adı</label>
                        <input type="text" name="rol_adi[]" placeholder="Örn: Dom Cobb">
                    </div>
                </div>
            <?php endfor; ?>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn primary">Filmi Kaydet</button>
            <a href="film-yonetim.php" class="btn ghost">Vazgeç</a>
        </div>

    </form>

</section>

</body>
</html>