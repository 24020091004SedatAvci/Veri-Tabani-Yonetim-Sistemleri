<%-- 
    Document   : detay
    Created on : 7 May 2026, 18:51:44
    Author     : Sedat
--%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");

    if (idParam == null || idParam.trim().equals("")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement psTarif = null;
    PreparedStatement psMalzeme = null;
    ResultSet rsTarif = null;
    ResultSet rsMalzeme = null;

    String tarifAdi = "";
    String kategoriAdi = "";
    String aciklama = "";
    String fotografUrl = "";
    int hazirlamaSuresi = 0;

    try {
        conn = DBConnection.getConnection();

        String sqlTarif = "SELECT t.*, k.kategori_adi FROM tarifler t " +
                          "INNER JOIN kategoriler k ON t.kategori_id = k.id " +
                          "WHERE t.id = ?";

        psTarif = conn.prepareStatement(sqlTarif);
        psTarif.setInt(1, Integer.parseInt(idParam));
        rsTarif = psTarif.executeQuery();

        if (rsTarif.next()) {
            tarifAdi = rsTarif.getString("tarif_adi");
            kategoriAdi = rsTarif.getString("kategori_adi");
            aciklama = rsTarif.getString("aciklama");
            hazirlamaSuresi = rsTarif.getInt("hazirlama_suresi");
            fotografUrl = rsTarif.getString("fotograf_url");

            if (fotografUrl == null || fotografUrl.trim().equals("")) {
                fotografUrl = "https://images.unsplash.com/photo-1547592166-23ac45744acd";
            }
        } else {
            out.println("Tarif bulunamadı.");
            return;
        }

        String sqlMalzeme = "SELECT m.malzeme_adi, tm.miktar " +
                            "FROM tarif_malzemeleri tm " +
                            "INNER JOIN malzemeler m ON tm.malzeme_id = m.id " +
                            "WHERE tm.tarif_id = ?";

        psMalzeme = conn.prepareStatement(sqlMalzeme);
        psMalzeme.setInt(1, Integer.parseInt(idParam));
        rsMalzeme = psMalzeme.executeQuery();

    } catch (Exception e) {
        out.println("<p style='color:red;'>Hata: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Detay - JSP</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
    <h1>Tarif Detay</h1>
    <p>Seçilen yemeğin bilgileri ve alışveriş listesi.</p>
</header>

<div class="container">

    <div class="top-bar">
        <h2 class="page-title"><%= tarifAdi %></h2>

        <div>
            <a href="index.jsp" class="btn btn-secondary">Ana Sayfa</a>
            <a href="tarif_crud.jsp" class="btn">Tarif Yönetimi</a>
        </div>
    </div>

    <div class="detail-box">
        <div>
            <img src="<%= fotografUrl %>" alt="Yemek Fotoğrafı">
        </div>

        <div class="detail-content">
            <h2><%= tarifAdi %></h2>

            <span class="badge">Kategori: <%= kategoriAdi %></span>
            <span class="badge">Süre: <%= hazirlamaSuresi %> dk</span>

            <h3>Tarif Açıklaması</h3>
            <p class="recipe-description"><%= aciklama %></p>
        </div>
    </div>

    <h2 class="section-title">Alışveriş Listesi</h2>

    <div class="table-wrapper">
        <table>
            <tr>
                <th>Malzeme</th>
                <th>Miktar</th>
            </tr>

            <%
                boolean malzemeVar = false;

                try {
                    while (rsMalzeme != null && rsMalzeme.next()) {
                        malzemeVar = true;
            %>

            <tr>
                <td><%= rsMalzeme.getString("malzeme_adi") %></td>
                <td><%= rsMalzeme.getString("miktar") %></td>
            </tr>

            <%
                    }

                    if (!malzemeVar) {
            %>

            <tr>
                <td colspan="2">Bu tarif için malzeme eklenmemiş.</td>
            </tr>

            <%
                    }

                } catch (Exception e) {
                    out.println("<tr><td colspan='2' style='color:red;'>Hata: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rsMalzeme != null) rsMalzeme.close();
                    if (rsTarif != null) rsTarif.close();
                    if (psMalzeme != null) psMalzeme.close();
                    if (psTarif != null) psTarif.close();
                    if (conn != null) conn.close();
                }
            %>

        </table>
    </div>

</div>

</body>
</html>