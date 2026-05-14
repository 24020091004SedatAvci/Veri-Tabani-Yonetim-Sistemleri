<%-- 
    Document   : sehir_detaylari
    Created on : 14 May 2026, 18:35:10
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Şehir Detayları</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="main-container">
        <%
            String cityIdStr = request.getParameter("cityId");
            if(cityIdStr != null) {
                int cityId = Integer.parseInt(cityIdStr);
                try (Connection conn = DBConnection.getConnection()) {
                    
                    // Şehir Başlığı
                    PreparedStatement psSehir = conn.prepareStatement("SELECT sehir_adi, bolge FROM sehirler WHERE id = ?");
                    psSehir.setInt(1, cityId);
                    ResultSet rsSehir = psSehir.executeQuery();
                    if(rsSehir.next()) {
        %>
                        <div class="hero-section" style="padding: 2rem; margin-bottom: 2rem;">
                            <h1><%= rsSehir.getString("sehir_adi") %></h1>
                            <p><%= rsSehir.getString("bolge") %> Bölgesi</p>
                        </div>
        <%          } rsSehir.close(); psSehir.close(); %>

                    <!-- Şehrin Mekanları -->
                    <h2 class="section-title">🏛️ Bu Şehirdeki Mekanlar</h2>
                    <div class="card-grid" style="margin-bottom: 3rem;">
        <%
                    PreparedStatement psMekan = conn.prepareStatement("SELECT * FROM mekanlar WHERE sehir_id = ?");
                    psMekan.setInt(1, cityId);
                    ResultSet rsMekan = psMekan.executeQuery();
                    boolean mekanVar = false;
                    
                    while(rsMekan.next()) { 
                        mekanVar = true;
                        String resim = rsMekan.getString("resim_url");
                        if(resim == null || resim.isEmpty()) resim = "https://via.placeholder.com/400x200?text=Gorsel+Yok";
        %>
                        <div class="card">
                            <img src="<%= resim %>" class="card-img" style="height: 180px;">
                            <div class="card-content">
                                <span class="card-badge"><%= rsMekan.getString("tur") %></span>
                                <h3 class="card-title"><%= rsMekan.getString("mekan_adi") %></h3>
                                <a href="mekan_detaylari.jsp?placeId=<%= rsMekan.getInt("id") %>" class="btn" style="width: 100%; padding: 0.5rem; text-align: center;">Mekana Git</a>
                            </div>
                        </div>
        <%          } 
                    if(!mekanVar) out.println("<p>Bu şehre ait mekan kaydı bulunmuyor.</p>");
                    rsMekan.close(); psMekan.close(); 
        %>
                    </div>

                    <!-- Şehrin Rehberleri (Eşleşme Tablosundan) -->
                    <h2 class="section-title">🗺️ Bu Şehirde Görevli Rehberler</h2>
                    <div class="card-grid">
        <%
                    String rehberQuery = "SELECT r.* FROM rehberler r JOIN sehir_rehber_eslesme srm ON r.id = srm.rehber_id WHERE srm.sehir_id = ?";
                    PreparedStatement psRehber = conn.prepareStatement(rehberQuery);
                    psRehber.setInt(1, cityId);
                    ResultSet rsRehber = psRehber.executeQuery();
                    boolean rehberVar = false;
                    
                    while(rsRehber.next()) { 
                        rehberVar = true;
        %>
                        <div class="card" style="padding: 1.5rem; border-left: 5px solid #10b981;">
                            <h3><%= rsRehber.getString("rehber_adi") %></h3>
                            <p style="color: #475569; margin-top: 0.5rem;">Uzmanlık: <%= rsRehber.getString("uzmanlik_alani") %></p>
                            <p style="color: #475569;">İletişim: <%= rsRehber.getString("iletisim") %></p>
                        </div>
        <%          } 
                    if(!rehberVar) out.println("<p>Bu şehre atanmış bir rehber bulunmuyor.</p>");
                    rsRehber.close(); psRehber.close();
                } catch (Exception e) { out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>"); }
            }
        %>
        </div>

            <div class="back-area">
                <a href="index.jsp" class="btn btn-back">Ana Sayfaya Dön</a>
            </div>
    </div>
</body>
</html>