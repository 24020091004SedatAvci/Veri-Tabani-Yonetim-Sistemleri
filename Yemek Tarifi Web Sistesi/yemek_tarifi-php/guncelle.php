<?php
include "baglanti.php";

if (!isset($_GET["id"])) {
    header("Location: tarif_crud.php");
    exit;
}

$id = $_GET["id"];

// Tarif bilgilerini getir
$stmt = $db->prepare("
    SELECT * FROM tarifler
    WHERE id = ?
");
$stmt->execute([$id]);
$tarif = $stmt->fetch();

if (!$tarif) {
    echo "Tarif bulunamadı.";
    exit;
}

// Kategorileri getir
$kategoriler = $db->query("SELECT * FROM kategoriler ORDER BY kategori_adi ASC");

// Güncelleme işlemi
if (isset($_POST["guncelle"])) {
    $sql = "
        UPDATE tarifler
        SET kategori_id = ?,
            tarif_adi = ?,
            aciklama = ?,
            hazirlama_suresi = ?,
            fotograf_url = ?
        WHERE id = ?
    ";

    $stmt = $db->prepare($sql);
    $stmt->execute([
        $_POST["kategori_id"],
        $_POST["tarif_adi"],
        $_POST["aciklama"],
        $_POST["hazirlama_suresi"],
        $_POST["fotograf_url"],
        $id
    ]);

    header("Location: tarif_crud.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Güncelle</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header>
    <h1>Tarif Güncelle</h1>
    <p>Seçilen tarifin bilgilerini düzenle.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title">Tarif Düzenleme</h2>

        <div>
            <a href="index.php" class="btn btn-secondary">Ana Sayfa</a>
            <a href="tarif_crud.php" class="btn">Tarif Yönetimi</a>
        </div>
    </div>

    <div class="form-box">
        <form method="post">

            <div class="form-grid">

                <div class="form-group">
                    <label>Tarif Adı</label>
                    <input 
                        type="text" 
                        name="tarif_adi" 
                        value="<?php echo htmlspecialchars($tarif['tarif_adi']); ?>" 
                        required>
                </div>

                <div class="form-group">
                    <label>Kategori</label>
                    <select name="kategori_id" required>
                        <?php foreach ($kategoriler as $kategori) { ?>
                            <option 
                                value="<?php echo $kategori['id']; ?>"
                                <?php if ($kategori['id'] == $tarif['kategori_id']) echo "selected"; ?>>
                                <?php echo htmlspecialchars($kategori['kategori_adi']); ?>
                            </option>
                        <?php } ?>
                    </select>
                </div>

                <div class="form-group">
                    <label>Hazırlama Süresi</label>
                    <input 
                        type="number" 
                        name="hazirlama_suresi" 
                        value="<?php echo htmlspecialchars($tarif['hazirlama_suresi']); ?>" 
                        required>
                </div>

                <div class="form-group">
                    <label>Fotoğraf URL</label>
                    <input 
                        type="text" 
                        name="fotograf_url" 
                        value="<?php echo htmlspecialchars($tarif['fotograf_url']); ?>">
                </div>

                <div class="form-group full">
                    <label>Açıklama</label>
                    <textarea name="aciklama" required><?php echo htmlspecialchars($tarif['aciklama']); ?></textarea>
                </div>

            </div>

            <br>

            <button class="btn" type="submit" name="guncelle">
                Güncelle
            </button>

        </form>
    </div>

</div>

</body>
</html>