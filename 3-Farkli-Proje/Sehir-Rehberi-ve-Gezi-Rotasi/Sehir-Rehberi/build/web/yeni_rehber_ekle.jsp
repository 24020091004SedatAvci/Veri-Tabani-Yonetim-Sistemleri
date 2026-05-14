<%-- 
    Document   : yeni_rehber_ekle
    Created on : 14 May 2026, 19:35:16
    Author     : Sedat
--%>

<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Yeni Rehber Ekle</title>
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
            <h2 style="text-align: center; color: #1e293b; margin-bottom: 0.5rem;">👨‍🏫 Yeni Rehber Ekle</h2>
            <p style="text-align: center; color: #64748b; margin-bottom: 2rem;">Sisteme yeni bir uzman rehber tanımlayın.</p>

            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String rehberAdi = request.getParameter("rehberAdi");
                    String uzmanlik = request.getParameter("uzmanlik");
                    String iletisim = request.getParameter("iletisim");
                    int sehirId = Integer.parseInt(request.getParameter("sehirId"));

                    Connection conn = null;
                    PreparedStatement psRehber = null;
                    PreparedStatement psEslesme = null;
                    ResultSet rsKeys = null;
                    
                    try {
                        conn = DBConnection.getConnection();
                        // 1. Önce Rehberi Ekliyoruz ve Oluşan ID'yi Alıyoruz (RETURN_GENERATED_KEYS)
                        String sqlRehber = "INSERT INTO rehberler (rehber_adi, uzmanlik_alani, iletisim) VALUES (?, ?, ?)";
                        psRehber = conn.prepareStatement(sqlRehber, Statement.RETURN_GENERATED_KEYS);
                        psRehber.setString(1, rehberAdi);
                        psRehber.setString(2, uzmanlik);
                        psRehber.setString(3, iletisim);
                        psRehber.executeUpdate();
                        
                        rsKeys = psRehber.getGeneratedKeys();
                        int yeniRehberId = -1;
                        if(rsKeys.next()) {
                            yeniRehberId = rsKeys.getInt(1); // Postgres Serial ID'si çekildi
                        }
                        
                        // 2. Eğer Rehber başarıyla eklendiyse, Eşleşme tablosuna şehri atıyoruz
                        if(yeniRehberId != -1) {
                            String sqlEslesme = "INSERT INTO sehir_rehber_eslesme (sehir_id, rehber_id) VALUES (?, ?)";
                            psEslesme = conn.prepareStatement(sqlEslesme);
                            psEslesme.setInt(1, sehirId);
                            psEslesme.setInt(2, yeniRehberId);
                            psEslesme.executeUpdate();
                        }

                        out.println("<div style='background: #d1fae5; color: #047857; padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem; text-align: center; font-weight: bold;'>✨ Rehber sisteme eklendi ve şehre atandı!</div>");
                    } catch (Exception e) { 
                        out.println("<div style='background: #fee2e2; color: #b91c1c; padding: 1rem; border-radius: 10px; margin-bottom: 1.5rem;'>Hata: " + e.getMessage() + "</div>");
                    } finally {
                        if(rsKeys != null) rsKeys.close();
                        if(psRehber != null) psRehber.close();
                        if(psEslesme != null) psEslesme.close();
                        if(conn != null) conn.close();
                    }
                }
            %>

            <form method="POST">
                <div class="form-group">
                    <label>Adı Soyadı</label>
                    <input type="text" name="rehberAdi" placeholder="Örn: Sedat Avcı" required>
                </div>

                <div class="form-group">
                    <label>Uzmanlık Alanı</label>
                    <input type="text" name="uzmanlik" placeholder="Örn: Kültür Turizmi, Doğa Yürüyüşü" required>
                </div>

                <div class="form-group">
                    <label>İletişim Numarası</label>
                    <input type="text" name="iletisim" placeholder="Örn: 05xx xxx xx xx" required>
                </div>

                <div class="form-group">
                    <label>Hangi Şehirde Görev Yapacak?</label>
                    <select name="sehirId" required>
                        <option value="">-- Görev Yapacağı Şehri Seçin --</option>
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

                <div class="form-actions">
                    <a href="index.jsp" class="btn btn-back">Ana Sayfaya Dön</a>
                    <button type="submit" class="btn">Rehberi Sisteme Ekle</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>