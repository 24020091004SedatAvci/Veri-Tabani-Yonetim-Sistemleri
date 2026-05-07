<?php
include "baglanti.php";

if (isset($_POST["ekle"])) {

    $sql = "INSERT INTO tarifler 
    (kategori_id, tarif_adi, aciklama, hazirlama_suresi, fotograf_url)
    VALUES (?, ?, ?, ?, ?)";

    $stmt = $db->prepare($sql);
    $stmt->execute([
        $_POST["kategori_id"],
        $_POST["tarif_adi"],
        $_POST["aciklama"],
        $_POST["hazirlama_suresi"],
        $_POST["fotograf_url"]
    ]);

    $tarif_id = $db->lastInsertId();

    if (!empty($_POST["malzemeler"])) {
        foreach ($_POST["malzemeler"] as $malzeme_id) {

            $miktar = $_POST["miktar"][$malzeme_id] ?? "";

            $malzemeEkle = $db->prepare("
                INSERT INTO tarif_malzemeleri 
                (tarif_id, malzeme_id, miktar)
                VALUES (?, ?, ?)
            ");

            $malzemeEkle->execute([
                $tarif_id,
                $malzeme_id,
                $miktar
            ]);
        }
    }

    header("Location: tarif_crud.php");
    exit;
}

if (isset($_GET["sil"])) {
    $stmt = $db->prepare("DELETE FROM tarifler WHERE id = ?");
    $stmt->execute([$_GET["sil"]]);

    header("Location: tarif_crud.php");
    exit;
}

$kategoriler = $db->query("SELECT * FROM kategoriler ORDER BY kategori_adi ASC");
$malzemeler = $db->query("SELECT * FROM malzemeler ORDER BY malzeme_adi ASC");

$tarifler = $db->query("
    SELECT tarifler.*, kategoriler.kategori_adi 
    FROM tarifler 
    INNER JOIN kategoriler ON tarifler.kategori_id = kategoriler.id
    ORDER BY tarifler.id DESC
");
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Yeni Tarif Ekle</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<header class="site-header">
    <h1>Tarif Yönetimi</h1>
    <p>Tarifleri listele, yeni tarif ekle, güncelle, sil ve malzeme seç.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title">Tarif Ekranı</h2>
        <a href="index.php" class="btn btn-secondary">Ana Sayfa</a>
    </div>

    <!-- TARİF LİSTESİ YUKARI ALINDI -->
    <h2 class="section-title">Tarif Listesi</h2>

    <div class="table-wrapper recipe-list-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Tarif Adı</th>
                <th>Kategori</th>
                <th>Süre</th>
                <th>İşlem</th>
            </tr>

            <?php foreach ($tarifler as $tarif) { ?>
                <tr>
                    <td><?php echo $tarif['id']; ?></td>

                    <td>
                        <strong><?php echo htmlspecialchars($tarif['tarif_adi']); ?></strong>
                    </td>

                    <td><?php echo htmlspecialchars($tarif['kategori_adi']); ?></td>

                    <td><?php echo htmlspecialchars($tarif['hazirlama_suresi']); ?> dk</td>

                    <td class="action-links">
                        <a class="btn btn-secondary" href="detay.php?id=<?php echo $tarif['id']; ?>">
                            Detay
                        </a>

                        <a class="btn" href="guncelle.php?id=<?php echo $tarif['id']; ?>">
                            Güncelle
                        </a>

                        <a class="btn btn-danger" 
                           href="tarif_crud.php?sil=<?php echo $tarif['id']; ?>" 
                           onclick="return confirm('Bu tarifi silmek istediğinize emin misiniz?')">
                           Sil
                        </a>
                    </td>
                </tr>
            <?php } ?>
        </table>
    </div>

    <!-- FORM AŞAĞI ALINDI -->
    <h2 class="section-title">Yeni Tarif Ekle</h2>

    <form method="post" class="form-card">

        <div class="form-grid">

            <div class="form-group">
                <label>Tarif Adı</label>
                <input type="text" name="tarif_adi" placeholder="Örn: Tavuk Sote" required>
            </div>

            <div class="form-group">
                <label>Kategori</label>
                <select name="kategori_id" required>
                    <?php foreach ($kategoriler as $kategori) { ?>
                        <option value="<?php echo $kategori['id']; ?>">
                            <?php echo htmlspecialchars($kategori['kategori_adi']); ?>
                        </option>
                    <?php } ?>
                </select>
            </div>

            <div class="form-group">
                <label>Hazırlama Süresi</label>
                <input type="number" name="hazirlama_suresi" placeholder="Örn: 45" required>
            </div>

            <div class="form-group">
                <label>Fotoğraf URL</label>
                <input type="text" name="fotograf_url" placeholder="Örn: https://...">
            </div>

            <div class="form-group full">
                <label>Açıklama</label>
                <textarea name="aciklama" placeholder="Tarifin hazırlanışını yazınız..." required></textarea>
            </div>

        </div>

        <h2 class="section-title">Malzeme Seçme</h2>

        <div class="material-search-box">
            <input 
                type="text" 
                id="malzemeArama" 
                placeholder="Malzeme ara... Örn: tavuk, tuz, domates"
                onkeyup="malzemeAra()"
            >
        </div>

        <div class="table-wrapper">
            <table class="material-table" id="malzemeTablosu">
                <tr>
                    <th>Seç</th>
                    <th>Malzeme</th>
                    <th>Miktar</th>
                </tr>

                <?php foreach ($malzemeler as $malzeme) { ?>
                    <tr>
                        <td>
                            <input type="checkbox" 
                                   name="malzemeler[]" 
                                   value="<?php echo $malzeme['id']; ?>">
                        </td>

                        <td class="malzeme-adi">
                            <?php echo htmlspecialchars($malzeme['malzeme_adi']); ?>
                        </td>

                        <td>
                            <input type="text" 
                                   name="miktar[<?php echo $malzeme['id']; ?>]" 
                                   placeholder="Örn: 1 adet, 500 gr, 2 kaşık">
                        </td>
                    </tr>
                <?php } ?>
            </table>
        </div>

        <br>

        <button class="btn" type="submit" name="ekle">Tarifi Ekle</button>

    </form>

</div>

<script>
function malzemeAra() {
    let input = document.getElementById("malzemeArama");
    let filtre = input.value.toLocaleLowerCase("tr-TR");
    let tablo = document.getElementById("malzemeTablosu");
    let satirlar = tablo.getElementsByTagName("tr");

    for (let i = 1; i < satirlar.length; i++) {
        let malzemeHucre = satirlar[i].getElementsByClassName("malzeme-adi")[0];

        if (malzemeHucre) {
            let malzemeAdi = malzemeHucre.textContent || malzemeHucre.innerText;
            malzemeAdi = malzemeAdi.toLocaleLowerCase("tr-TR");

            if (malzemeAdi.indexOf(filtre) > -1) {
                satirlar[i].style.display = "";
            } else {
                satirlar[i].style.display = "none";
            }
        }
    }
}
</script>

</body>
</html>