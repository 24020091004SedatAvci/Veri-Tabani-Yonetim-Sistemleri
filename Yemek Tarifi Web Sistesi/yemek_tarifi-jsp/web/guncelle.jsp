<%-- 
    Document   : guncelle
    Created on : 7 May 2026, 18:52:07
    Author     : Sedat
--%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().equals("")) {
        response.sendRedirect("tarif_crud.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement psTarif = null;
    Statement stKat = null;
    ResultSet rsTarif = null;
    ResultSet rsKat = null;

    int id = Integer.parseInt(idParam);

    try {
        conn = DBConnection.getConnection();

        String sqlTarif = "SELECT * FROM tarifler WHERE id = ?";
        psTarif = conn.prepareStatement(sqlTarif);
        psTarif.setInt(1, id);
        rsTarif = psTarif.executeQuery();

        if (!rsTarif.next()) {
            out.println("Tarif bulunamadı.");
            return;
        }

        stKat = conn.createStatement();
        rsKat = stKat.executeQuery("SELECT * FROM kategoriler ORDER BY kategori_adi ASC");

%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Güncelle - JSP</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
    <h1>Tarif Güncelle</h1>
    <p>Seçilen tarifin bilgilerini düzenle.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title">Tarif Düzenleme</h2>

        <div>
            <a href="index.jsp" class="btn btn-secondary">Ana Sayfa</a>
            <a href="tarif_crud.jsp" class="btn">Tarif Yönetimi</a>
        </div>
    </div>

    <form method="post" action="tarif_guncelle.jsp" class="form-card">

        <input type="hidden" name="id" value="<%= rsTarif.getInt("id") %>">

        <div class="form-grid">

            <div class="form-group">
                <label>Tarif Adı</label>
                <input 
                    type="text" 
                    name="tarif_adi" 
                    value="<%= rsTarif.getString("tarif_adi") %>" 
                    required>
            </div>

            <div class="form-group">
                <label>Kategori</label>
                <select name="kategori_id" required>

                    <%
                        while (rsKat.next()) {
                    %>

                    <option 
                        value="<%= rsKat.getInt("id") %>"
                        <%= rsKat.getInt("id") == rsTarif.getInt("kategori_id") ? "selected" : "" %>>
                        <%= rsKat.getString("kategori_adi") %>
                    </option>

                    <%
                        }
                    %>

                </select>
            </div>

            <div class="form-group">
                <label>Hazırlama Süresi</label>
                <input 
                    type="number" 
                    name="hazirlama_suresi" 
                    value="<%= rsTarif.getInt("hazirlama_suresi") %>" 
                    required>
            </div>

            <div class="form-group">
                <label>Fotoğraf URL</label>
                <input 
                    type="text" 
                    name="fotograf_url" 
                    value="<%= rsTarif.getString("fotograf_url") == null ? "" : rsTarif.getString("fotograf_url") %>">
            </div>

            <div class="form-group full">
                <label>Açıklama</label>
                <textarea name="aciklama" required><%= rsTarif.getString("aciklama") == null ? "" : rsTarif.getString("aciklama") %></textarea>
            </div>

        </div>

        <br>

        <button class="btn" type="submit">Güncelle</button>

    </form>

</div>

</body>
</html>

<%

    } catch (Exception e) {
        out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>");
        e.printStackTrace();

    } finally {
        if (rsKat != null) rsKat.close();
        if (rsTarif != null) rsTarif.close();
        if (stKat != null) stKat.close();
        if (psTarif != null) psTarif.close();
        if (conn != null) conn.close();
    }
%>