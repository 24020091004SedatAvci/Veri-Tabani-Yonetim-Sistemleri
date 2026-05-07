    <%-- 
    Document   : index
    Created on : 7 May 2026, 18:12:34
    Author     : Sedat
--%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="db.DBConnection" %>

<!DOCTYPE html>
<html lang="tr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Yemek Tarifleri</title>
    <link rel="Stylesheet" href="style.css">
</head>
<body>
    
    <header class="site-header">
        <h1>Yemek Tarifleri</h1>
    </header>
    
    <div class="container">
        <div class="top-bar">
            <h2 class="page-title">Tarifler</h2>
            <a href="tarif_crud.jsp" class="btn">+ Yeni Tarif Ekle</a>
        </div>
        
        <div class="card-list">
             <%
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;
                int tarifSayisi = 0;

                    try{
                    conn = DBConnection.getConnection();

                    String sql = "SELECT t.*, k.kategori_adi FROM tarifler t " +
                                 "INNER JOIN kategoriler k ON t.kategori_id = k.id " +
                                 "ORDER BY t.id DESC";

                    st = conn.createStatement();
                    rs = st.executeQuery(sql);

                    while (rs.next()) {
                        tarifSayisi++;

                        String foto = rs.getString("fotograf_url");

                        if (foto == null || foto.trim().equals("")) {
                            foto = "https://images.unsplash.com/photo-1547592166-23ac45744acd";
                        }
            %>
            
            <div class="card">;
                <img src="<%= foto %>" alt="Yemek Fotoğrafı">

            <div class="card-body">
                <h3><%= rs.getString("tarif_adi") %></h3>
                <p><b>Kategori:</b> <%= rs.getString("kategori_adi") %></p>
                <p><b>Hazırlama Süresi:</b> <%= rs.getInt("hazirlama_suresi") %> dk</p>

                <a class="btn" href="detay.jsp?id=<%= rs.getInt("id") %>">
                    Detay Gör
                </a>
            </div>
        </div>
                    
   <%
            }

        } catch (Exception e) {
            out.println("<p>Hata: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (conn != null) conn.close();
        }
    %>    
    </div>  
</div>     
</body>
</html>
