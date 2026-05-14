<%-- 
    Document   : yeni_etkinlik_ekle
    Created on : 14 May 2026, 19:35:00
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Yeni Etkinlik Ekle</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .form-wrapper { background: rgba(255,255,255,0.95); padding: 3rem; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.08); max-width: 600px; margin: 0 auto; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 0.5rem; color: #334155; }
        .form-group input, .form-group select { width: 100%; padding: 1rem; border: 2px solid #e2e8f0; border-radius: 12px; font-family: inherit; font-size: 1rem; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #4F46E5; }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="form-wrapper">
            <h2 style="text-align: center; color: #1e293b; margin-bottom: 0.5rem;">📅 Yeni Etkinlik Ekle</h2>
            <p style="text-align: center; color: #64748b; margin-bottom: 2rem;">Mekanlara planlanmış etkinlikleri tanımlayın.</p>

            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    int mekanId = Integer.parseInt(request.getParameter("mekanId"));
                    String etkinlikAdi = request.getParameter("etkinlikAdi");
                    String tarih = request.getParameter("tarih");
                    String ucret = request.getParameter("ucret");

                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement("INSERT INTO etkinlikler (mekan_id, etkinlik_adi, tarih, ucret) VALUES (?, ?, ?::date, ?)")) {
                        
                        ps.setInt(1, mekanId);
                        ps.setString(2, etkinlikAdi);
                        ps.setString(3, tarih);
                        ps.setString(4, ucret);
                        ps.executeUpdate();
                        out.println("<div style='background: #d1fae5; color: #047857; padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem; text-align: center; font-weight: bold;'>✨ Etkinlik başarıyla eklendi!</div>");
                    } catch (Exception e) { 
                        out.println("<div style='background: #fee2e2; color: #b91c1c; padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem;'>Hata: " + e.getMessage() + "</div>");
                    }
                }
            %>

            <form method="POST">
                <div class="form-group">
                    <label>Hangi Mekanda Yapılacak?</label>
                    <select name="mekanId" required>
                        <option value="">-- Mekan Seçiniz --</option>
                        <% 
                            try (Connection conn = DBConnection.getConnection();
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT m.id, m.mekan_adi, s.sehir_adi FROM mekanlar m JOIN sehirler s ON m.sehir_id = s.id ORDER BY s.sehir_adi ASC")) {
                                while(rs.next()) {
                        %>
                                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("sehir_adi") %> - <%= rs.getString("mekan_adi") %></option>
                        <%      }
                            } catch (Exception e) { e.printStackTrace(); } 
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Etkinlik Adı</label>
                    <input type="text" name="etkinlikAdi" placeholder="Örn: Açık Hava Konseri" required>
                </div>

                <div class="form-group">
                    <label>Tarih</label>
                    <input type="date" name="tarih" required>
                </div>

                <div class="form-group">
                    <label>Ücret Bilgisi</label>
                    <input type="text" name="ucret" placeholder="Örn: Ücretsiz, 150 TL vb." required>
                </div>

                <div class="form-actions">
                    <a href="index.jsp" class="btn btn-back">Ana Sayfaya Dön</a>
                    <button type="submit" class="btn">Etkinliği Kaydet</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>