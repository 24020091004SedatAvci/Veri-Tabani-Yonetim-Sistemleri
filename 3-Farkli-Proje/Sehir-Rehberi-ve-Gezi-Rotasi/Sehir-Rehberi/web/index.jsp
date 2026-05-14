<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Şehir Rehberi | Keşfet</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="main-container">
        
        <!-- Üst Menü / Kontrol Paneli -->
        <div class="hero-section" style="padding: 2.5rem; margin-bottom: 2.5rem;">
            <h1>Sistem Yönetim Merkezi</h1>
            <p>Rehberleri, mekanları ve şehirleri buradan organize edebilirsiniz.</p>
            
            <div class="admin-actions">
                <a href="arama.jsp" class="btn btn-secondary">🔍 Gelişmiş Arama</a>
                <a href="yeni_mekan_ekle.jsp" class="btn btn-success">+ Mekan Tanımla</a>
                <a href="yeni_etkinlik_ekle.jsp" class="btn btn-warning">+ Etkinlik Oluştur</a>
                <a href="yeni_rehber_ekle.jsp" class="btn btn-pink">+ Rehber Kaydet</a>
            </div>
        </div>

        <!-- 1. BÖLÜM: ŞEHİR KARTVİZİTLERİ -->
        <h2 class="section-title">📍 Şehir Kartvizitleri</h2>
        <div class="card-grid" style="margin-bottom: 4rem;">
            <% 
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM sehirler ORDER BY sehir_adi ASC")) {
                     
                    while(rs.next()) {
            %>
                <div class="card city-card">
                    <div class="city-icon">📍</div>

                    <h3 class="card-title"><%= rs.getString("sehir_adi") %></h3>

                    <div class="city-meta">
                        <%= rs.getString("bolge") %> Bölgesi
                    </div>

                    <p class="card-location">
                        Kayıtlı nüfus: <strong><%= rs.getInt("nufus") %></strong>
                    </p>

                    <a href="sehir_detaylari.jsp?cityId=<%= rs.getInt("id") %>" class="btn">
                        Detayları Görüntüle
                    </a>
                </div>
            <%      }
                } catch (Exception e) { out.println("<p style='color:red;'>Bağlantı Hatası: " + e.getMessage() + "</p>"); } 
            %>
        </div>

        <!-- 2. BÖLÜM: SİSTEMDEKİ SON MEKANLAR -->
        <h2 class="section-title">🖼️ Güncel Mekan Galerisi</h2>
        <div class="card-grid" style="margin-bottom: 4rem;">
            <% 
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rsMekan = stmt.executeQuery("SELECT m.*, s.sehir_adi FROM mekanlar m JOIN sehirler s ON m.sehir_id = s.id ORDER BY m.id DESC LIMIT 3")) {
                     
                    while(rsMekan.next()) {
                        String resim = rsMekan.getString("resim_url");
                        if(resim == null || resim.isEmpty()) resim = "https://via.placeholder.com/400x200?text=Gorsel+Eklenmedi";
            %>
                <div class="card place-card">
                    <div class="card-img-wrap">
                        <img src="<%= resim %>" class="card-img" alt="Mekan Kapak">
                        <div class="place-chip">📍 <%= rsMekan.getString("sehir_adi") %></div>
                    </div>

                    <div class="card-content">
                        <span class="card-badge"><%= rsMekan.getString("tur") %></span>

                        <h3 class="card-title"><%= rsMekan.getString("mekan_adi") %></h3>

                        <p class="card-location">
                            Bu mekanı inceleyerek detaylara ve etkinliklere ulaşabilirsiniz.
                        </p>

                        <a href="mekan_detaylari.jsp?placeId=<%= rsMekan.getInt("id") %>" class="btn">
                            Mekanı İncele
                        </a>
                    </div>
                </div>
            <%      }
                } catch (Exception e) { out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>"); } 
            %>
        </div>

        <!-- 3. BÖLÜM: REHBER KADROMUZ -->
        <h2 class="section-title">🤝 Saha Rehberlerimiz</h2>
        <div class="card-grid">
            <% 
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rsRehber = stmt.executeQuery("SELECT * FROM rehberler")) {
                     
                    while(rsRehber.next()) {
            %>
                <div class="card guide-card">
                    <div class="guide-avatar">👨‍🏫</div>

                    <h3 class="card-title"><%= rsRehber.getString("rehber_adi") %></h3>

                    <p><strong>Uzmanlık:</strong> <%= rsRehber.getString("uzmanlik_alani") %></p>
                    <p><strong>İletişim:</strong> <%= rsRehber.getString("iletisim") %></p>
                </div>
            <%      }
                } catch (Exception e) { out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>"); } 
            %>
        </div>

    </div>
</body>
</html>