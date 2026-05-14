<%-- 
    Document   : arama
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Gelişmiş Arama</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>

<body>
    <div class="main-container">

        <div class="search-box">
            <h2 style="text-align: center; color: #1f2933; margin-bottom: 0.5rem;">
                Detaylı Mekan Filtreleme
            </h2>

            <p style="text-align: center; color: #6b7280; margin-bottom: 2rem;">
                Bölge, şehir veya mekan türüne göre arama yapabilirsiniz.
            </p>

            <%
                String seciliBolge = request.getParameter("bolge");
                String seciliSehirId = request.getParameter("sehirId");
                String seciliTur = request.getParameter("tur");

                if (seciliBolge == null) seciliBolge = "";
                if (seciliSehirId == null) seciliSehirId = "";
                if (seciliTur == null) seciliTur = "";
            %>

            <form method="GET" class="search-form">

                <!-- Bölge Seçimi -->
                <select name="bolge">
                    <option value="">-- Tüm Bölgeler --</option>

                    <option value="Akdeniz" <%= seciliBolge.equals("Akdeniz") ? "selected" : "" %>>
                        Akdeniz Bölgesi
                    </option>

                    <option value="Ege" <%= seciliBolge.equals("Ege") ? "selected" : "" %>>
                        Ege Bölgesi
                    </option>

                    <option value="Marmara" <%= seciliBolge.equals("Marmara") ? "selected" : "" %>>
                        Marmara Bölgesi
                    </option>

                    <option value="İç Anadolu" <%= seciliBolge.equals("İç Anadolu") ? "selected" : "" %>>
                        İç Anadolu Bölgesi
                    </option>

                    <option value="Karadeniz" <%= seciliBolge.equals("Karadeniz") ? "selected" : "" %>>
                        Karadeniz Bölgesi
                    </option>

                    <option value="Doğu Anadolu" <%= seciliBolge.equals("Doğu Anadolu") ? "selected" : "" %>>
                        Doğu Anadolu Bölgesi
                    </option>

                    <option value="Güneydoğu Anadolu" <%= seciliBolge.equals("Güneydoğu Anadolu") ? "selected" : "" %>>
                        Güneydoğu Anadolu Bölgesi
                    </option>
                </select>

                <!-- Şehir Seçimi -->
                <select name="sehirId">
                    <option value="">-- Tüm Şehirler --</option>

                    <%
                        try (
                            Connection conn = DBConnection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rsSehirler = stmt.executeQuery(
                                "SELECT id, sehir_adi FROM sehirler ORDER BY sehir_adi ASC"
                            )
                        ) {
                            while (rsSehirler.next()) {
                                String currentId = String.valueOf(rsSehirler.getInt("id"));
                                String selected = currentId.equals(seciliSehirId) ? "selected" : "";
                    %>

                                <option value="<%= currentId %>" <%= selected %>>
                                    <%= rsSehirler.getString("sehir_adi") %>
                                </option>

                    <%
                            }
                        } catch (Exception e) {
                            out.println("<option disabled>Şehirler yüklenemedi</option>");
                        }
                    %>
                </select>

                <!-- Tür Seçimi -->
                <select name="tur">
                    <option value="">-- Tüm Türler --</option>

                    <option value="Tarihi Yer" <%= seciliTur.equals("Tarihi Yer") ? "selected" : "" %>>
                        Tarihi Yer
                    </option>

                    <option value="Müze" <%= seciliTur.equals("Müze") ? "selected" : "" %>>
                        Müze
                    </option>

                    <option value="Doğa" <%= seciliTur.equals("Doğa") ? "selected" : "" %>>
                        Doğa
                    </option>

                    <option value="Park" <%= seciliTur.equals("Park") ? "selected" : "" %>>
                        Park
                    </option>

                    <option value="Restoran" <%= seciliTur.equals("Restoran") ? "selected" : "" %>>
                        Restoran
                    </option>

                    <option value="Çarşı" <%= seciliTur.equals("Çarşı") ? "selected" : "" %>>
                        Çarşı / Alışveriş
                    </option>
                </select>

                <button type="submit" class="btn">
                    Filtrele
                </button>
            </form>

            <hr style="margin-bottom: 2rem; border: none; border-top: 1px solid #e6e1d6;">

            <%
                try (Connection conn = DBConnection.getConnection()) {

                    String query =
                        "SELECT m.id, m.mekan_adi, m.tur, m.resim_url, s.sehir_adi, s.bolge " +
                        "FROM mekanlar m " +
                        "JOIN sehirler s ON m.sehir_id = s.id " +
                        "WHERE 1=1 ";

                    if (!seciliBolge.isEmpty()) {
                        query += "AND s.bolge ILIKE ? ";
                    }

                    if (!seciliSehirId.isEmpty()) {
                        query += "AND s.id = ? ";
                    }

                    if (!seciliTur.isEmpty()) {
                        query += "AND m.tur ILIKE ? ";
                    }

                    query += "ORDER BY s.sehir_adi ASC, m.mekan_adi ASC";

                    PreparedStatement ps = conn.prepareStatement(query);

                    int paramIndex = 1;

                    if (!seciliBolge.isEmpty()) {
                        ps.setString(paramIndex++, "%" + seciliBolge + "%");
                    }

                    if (!seciliSehirId.isEmpty()) {
                        ps.setInt(paramIndex++, Integer.parseInt(seciliSehirId));
                    }

                    if (!seciliTur.isEmpty()) {
                        ps.setString(paramIndex++, "%" + seciliTur + "%");
                    }

                    ResultSet rs = ps.executeQuery();

                    boolean sonucVar = false;
            %>

                    <div class="card-grid">

            <%
                    while (rs.next()) {
                        sonucVar = true;

                        String resim = rs.getString("resim_url");

                        if (resim == null || resim.trim().isEmpty()) {
                            resim = "https://via.placeholder.com/400x220?text=Gorsel+Yok";
                        }
            %>

                        <div class="card place-card">
                            <div class="card-img-wrap">
                                <img src="<%= resim %>" class="card-img" alt="Mekan Görseli">
                                <div class="place-chip">
                                    📍 <%= rs.getString("sehir_adi") %>
                                </div>
                            </div>

                            <div class="card-content">
                                <span class="card-badge">
                                    <%= rs.getString("tur") %>
                                </span>

                                <h3 class="card-title">
                                    <%= rs.getString("mekan_adi") %>
                                </h3>

                                <p class="card-location">
                                    <%= rs.getString("bolge") %> Bölgesi
                                </p>

                                <a href="mekan_detaylari.jsp?placeId=<%= rs.getInt("id") %>" class="btn">
                                    Detaya Git
                                </a>
                            </div>
                        </div>

            <%
                    }
            %>

                    </div>

            <%
                    if (!sonucVar) {
                        out.println(
                            "<div style='text-align:center; padding: 2rem; color: #6b7280;'>" +
                            "Aradığınız kriterlere uygun mekan bulunamadı." +
                            "</div>"
                        );
                    }

                    rs.close();
                    ps.close();

                } catch (Exception e) {
                    out.println(
                        "<div style='background:#f8dddd; color:#984949; padding:1rem; border-radius:12px;'>" +
                        "Hata: " + e.getMessage() +
                        "</div>"
                    );
                }
            %>

            <div class="back-area">
                <a href="index.jsp" class="btn btn-back">
                    ← Ana Sayfaya Dön
                </a>
            </div>

        </div>

    </div>
</body>
</html>