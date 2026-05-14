<%-- 
    Document   : mekan_detaylari
    Created on : 14 May 2026, 18:36:31
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mekan Detayları</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .info-card { background: rgba(255, 255, 255, 0.95); padding: 3rem; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .event-item { display: flex; justify-content: space-between; align-items: center; background: white; padding: 1.5rem; border-radius: 12px; border: 1px solid #e2e8f0; margin-bottom: 1rem; }
    </style>
</head>
<body>
    <div class="main-container" style="max-width: 900px;">
        <%
            String placeIdStr = request.getParameter("placeId");
            if(placeIdStr != null) {
                int placeId = Integer.parseInt(placeIdStr);
                try (Connection conn = DBConnection.getConnection()) {
                    
                    PreparedStatement ps = conn.prepareStatement(
                        "SELECT m.*, s.sehir_adi FROM mekanlar m JOIN sehirler s ON m.sehir_id = s.id WHERE m.id = ?");
                    ps.setInt(1, placeId);
                    ResultSet rs = ps.executeQuery();
                    
                    if(rs.next()) {
                        String resim = rs.getString("resim_url");
                        if(resim != null && !resim.isEmpty()) {
        %>
                            <div class="detail-image-box">
                                <img src="<%= resim %>" alt="Mekan Görseli">
                            </div>
        <%              } %>
        
                        <div class="info-card" style="position: relative; z-index: 2;">
                            <span class="card-badge">📍 <%= rs.getString("sehir_adi") %></span>
                            <span class="card-badge" style="background: #fce7f3; color: #be185d;">🏷️ <%= rs.getString("tur") %></span>
                            
                            <h1 style="font-size: 2.5rem; margin: 1rem 0;"><%= rs.getString("mekan_adi") %></h1>
                            <p style="font-size: 1.1rem; color: #475569; margin-bottom: 2rem; border-bottom: 1px solid #e2e8f0; padding-bottom: 2rem;">
                                <%= rs.getString("aciklama") %>
                            </p>
                            
                            <h3 style="margin-bottom: 1.5rem;">📅 Bu Mekandaki Etkinlikler</h3>
        <%
                            PreparedStatement psEtk = conn.prepareStatement("SELECT * FROM etkinlikler WHERE mekan_id = ? ORDER BY tarih ASC");
                            psEtk.setInt(1, placeId);
                            ResultSet rsEtk = psEtk.executeQuery();
                            
                            boolean etkinlikVar = false;
                            while(rsEtk.next()) {
                                etkinlikVar = true;
        %>
                                <div class="event-item">
                                    <div>
                                        <h4 style="font-size: 1.2rem; margin-bottom: 0.3rem;"><%= rsEtk.getString("etkinlik_adi") %></h4>
                                        <div style="color: #64748b;">Tarih: <%= rsEtk.getDate("tarih") %></div>
                                    </div>
                                    <div style="background: #d1fae5; color: #047857; padding: 0.5rem 1rem; border-radius: 8px; font-weight: bold;">
                                        <%= rsEtk.getString("ucret") %>
                                    </div>
                                </div>
        <%                  } 
                            if(!etkinlikVar) { out.println("<p style='color:#64748b;'>Bu mekanda henüz duyurulan bir etkinlik bulunmuyor.</p>"); }
                            rsEtk.close(); psEtk.close();
        %>
                            <div style="margin-top: 2rem; display: flex; gap: 1rem;">
                                <a href="javascript:history.back()" class="btn" style="background: #e2e8f0; color: #334155; box-shadow: none;">Geri Dön</a>
                            </div>
                        </div>
        <%          } else { out.println("<p>Mekan bulunamadı.</p>"); }
                    rs.close(); ps.close();
                } catch (Exception e) { out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>"); }
            }
        %>
    </div>
</body>
</html>