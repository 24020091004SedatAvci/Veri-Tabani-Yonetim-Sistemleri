<%-- 
    Document   : yeni_mekan_ekle
    Created on : 14 May 2026, 18:37:05
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Yeni Mekan Ekle</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .form-wrapper { background: rgba(255,255,255,0.9); padding: 3rem; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); max-width: 600px; margin: 0 auto; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 0.5rem; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 1rem; border: 1px solid #cbd5e1; border-radius: 10px; font-family: inherit; font-size: 1rem; }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="form-wrapper">
            <h2 style="text-align: center; margin-bottom: 2rem;">Yeni Mekan Ekle</h2>
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    int sehirId = Integer.parseInt(request.getParameter("sehirId"));
                    String mekanAdi = request.getParameter("mekanAdi");
                    String aciklama = request.getParameter("aciklama");
                    String tur = request.getParameter("tur");
                    String resimUrl = request.getParameter("resimUrl");

                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement ps = conn.prepareStatement("INSERT INTO mekanlar (sehir_id, mekan_adi, aciklama, tur, resim_url) VALUES (?, ?, ?, ?, ?)")) {
                        
                        ps.setInt(1, sehirId);
                        ps.setString(2, mekanAdi);
                        ps.setString(3, aciklama);
                        ps.setString(4, tur);
                        ps.setString(5, resimUrl);
                        ps.executeUpdate();
                        out.println("<div style='background: #d1fae5; color: #047857; padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem; text-align: center;'>Mekan başarıyla eklendi!</div>");
                    } catch (Exception e) { 
                        out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <form method="POST">
                <div class="form-group">
                    <label>Şehir Seçimi</label>
                    <select name="sehirId" required>
                        <option value="">-- Şehir Seçin --</option>
                        <% 
                            try (Connection conn = DBConnection.getConnection();
                                 Statement stmt = conn.createStatement();
                                 ResultSet rs = stmt.executeQuery("SELECT id, sehir_adi FROM sehirler ORDER BY sehir_adi ASC")) {
                                while(rs.next()) {
                        %>
                                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("sehir_adi") %></option>
                        <%      }
                            } catch (Exception e) { e.printStackTrace(); } 
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Mekan Adı</label>
                    <input type="text" name="mekanAdi" required>
                </div>
                <div class="form-group">
                    <label>Açıklama</label>
                    <textarea name="aciklama" required style="min-height: 100px; resize: vertical;"></textarea>
                </div>
                <div class="form-group">
                    <label>Tür (Müze, Park vb.)</label>
                    <input type="text" name="tur" required>
                </div>
                <div class="form-group">
                    <label>Resim URL (İsteğe Bağlı)</label>
                    <input type="text" name="resimUrl" placeholder="https://...">
                <div class="form-actions">
                    <a href="index.jsp" class="btn btn-back">Ana Sayfaya Dön</a>
                    <button type="submit" class="btn">Mekanı Kaydet</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>