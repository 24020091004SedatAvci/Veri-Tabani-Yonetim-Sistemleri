<%-- 
    Document   : tarif_crud
    Created on : 7 May 2026, 18:46:21
    Author     : Sedat
--%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Yönetimi - JSP</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
    <h1>Tarif Yönetimi</h1>
    <p>Tarif ekle, listele, güncelle, sil ve malzeme seç.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title">Tarif Ekranı</h2>
        <a href="index.jsp" class="btn btn-secondary">Ana Sayfa</a>
    </div>

    <h2 class="section-title">Tarif Listesi</h2>

    <div class="table-wrapper">
        <table>
            <tr>
                <th>ID</th>
                <th>Tarif Adı</th>
                <th>Kategori</th>
                <th>Süre</th>
                <th>İşlem</th>
            </tr>

            <%
                Connection conn = null;
                Statement stTarif = null;
                ResultSet rsTarif = null;

                try {
                    conn = DBConnection.getConnection();

                    String sqlTarif = "SELECT t.*, k.kategori_adi FROM tarifler t " +
                                      "INNER JOIN kategoriler k ON t.kategori_id = k.id " +
                                      "ORDER BY t.id DESC";

                    stTarif = conn.createStatement();
                    rsTarif = stTarif.executeQuery(sqlTarif);

                    while (rsTarif.next()) {
            %>

            <tr>
                <td><%= rsTarif.getInt("id") %></td>

                <td>
                    <strong><%= rsTarif.getString("tarif_adi") %></strong>
                </td>

                <td><%= rsTarif.getString("kategori_adi") %></td>

                <td><%= rsTarif.getInt("hazirlama_suresi") %> dk</td>

                <td class="action-links">
                    <a class="btn btn-secondary" href="detay.jsp?id=<%= rsTarif.getInt("id") %>">
                        Detay
                    </a>

                    <a class="btn" href="guncelle.jsp?id=<%= rsTarif.getInt("id") %>">
                        Güncelle
                    </a>

                    <a class="btn btn-danger"
                       href="tarif_sil.jsp?id=<%= rsTarif.getInt("id") %>"
                       onclick="return confirm('Bu tarifi silmek istediğinize emin misiniz?')">
                        Sil
                    </a>
                </td>
            </tr>

            <%
                    }

                } catch (Exception e) {
                    out.println("<tr><td colspan='5' style='color:red;'>Hata: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    if (rsTarif != null) rsTarif.close();
                    if (stTarif != null) stTarif.close();
                    if (conn != null) conn.close();
                }
            %>

        </table>
    </div>

    <h2 class="section-title">Yeni Tarif Ekle</h2>

    <form method="post" action="tarif_ekle.jsp" class="form-card">

        <div class="form-grid">

            <div class="form-group">
                <label>Tarif Adı</label>
                <input type="text" name="tarif_adi" placeholder="Örn: Tavuk Sote" required>
            </div>

            <div class="form-group">
                <label>Kategori</label>
                <select name="kategori_id" required>

                    <%
                        Connection connKat = null;
                        Statement stKat = null;
                        ResultSet rsKat = null;

                        try {
                            connKat = DBConnection.getConnection();

                            stKat = connKat.createStatement();
                            rsKat = stKat.executeQuery("SELECT * FROM kategoriler ORDER BY kategori_adi ASC");

                            while (rsKat.next()) {
                    %>

                    <option value="<%= rsKat.getInt("id") %>">
                        <%= rsKat.getString("kategori_adi") %>
                    </option>

                    <%
                            }

                        } catch (Exception e) {
                            out.println("<option>Hata oluştu</option>");
                            e.printStackTrace();
                        } finally {
                            if (rsKat != null) rsKat.close();
                            if (stKat != null) stKat.close();
                            if (connKat != null) connKat.close();
                        }
                    %>

                </select>
            </div>

            <div class="form-group">
                <label>Hazırlama Süresi</label>
                <input type="number" name="hazirlama_suresi" placeholder="Örn: 45" required>
            </div>

            <div class="form-group">
                <label>Fotoğraf URL</label>
                <input type="text" name="fotograf_url" placeholder="Örn: https://... veya tavuk.jpg">
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

                <%
                    Connection connMalzeme = null;
                    Statement stMalzeme = null;
                    ResultSet rsMalzeme = null;

                    try {
                        connMalzeme = DBConnection.getConnection();

                        stMalzeme = connMalzeme.createStatement();
                        rsMalzeme = stMalzeme.executeQuery("SELECT * FROM malzemeler ORDER BY malzeme_adi ASC");

                        while (rsMalzeme.next()) {
                %>

                <tr>
                    <td>
                        <input type="checkbox"
                               name="malzemeler"
                               value="<%= rsMalzeme.getInt("id") %>">
                    </td>

                    <td class="malzeme-adi">
                        <%= rsMalzeme.getString("malzeme_adi") %>
                    </td>

                    <td>
                        <input type="text"
                               name="miktar_<%= rsMalzeme.getInt("id") %>"
                               placeholder="Örn: 1 adet, 500 gr, 2 kaşık">
                    </td>
                </tr>

                <%
                        }

                    } catch (Exception e) {
                        out.println("<tr><td colspan='3' style='color:red;'>Hata: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (rsMalzeme != null) rsMalzeme.close();
                        if (stMalzeme != null) stMalzeme.close();
                        if (connMalzeme != null) connMalzeme.close();
                    }
                %>

            </table>
        </div>

        <br>

        <button class="btn" type="submit">Tarifi Ekle</button>

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
