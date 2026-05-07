<%-- 
    Document   : tarif_ekle
    Created on : 7 May 2026, 18:47:38
    Author     : Sedat
--%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String kategoriId = request.getParameter("kategori_id");
    String tarifAdi = request.getParameter("tarif_adi");
    String aciklama = request.getParameter("aciklama");
    String hazirlamaSuresi = request.getParameter("hazirlama_suresi");
    String fotografUrl = request.getParameter("fotograf_url");

    Connection conn = null;
    PreparedStatement psTarif = null;
    PreparedStatement psMalzeme = null;
    ResultSet generatedKeys = null;

    try {
        conn = DBConnection.getConnection();

        String sql = "INSERT INTO tarifler " +
                     "(kategori_id, tarif_adi, aciklama, hazirlama_suresi, fotograf_url) " +
                     "VALUES (?, ?, ?, ?, ?)";

        psTarif = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        psTarif.setInt(1, Integer.parseInt(kategoriId));
        psTarif.setString(2, tarifAdi);
        psTarif.setString(3, aciklama);
        psTarif.setInt(4, Integer.parseInt(hazirlamaSuresi));
        psTarif.setString(5, fotografUrl);

        psTarif.executeUpdate();

        generatedKeys = psTarif.getGeneratedKeys();

        int tarifId = 0;

        if (generatedKeys.next()) {
            tarifId = generatedKeys.getInt(1);
        }

        String[] secilenMalzemeler = request.getParameterValues("malzemeler");

        if (secilenMalzemeler != null && tarifId > 0) {
            String malzemeSql = "INSERT INTO tarif_malzemeleri " +
                                "(tarif_id, malzeme_id, miktar) " +
                                "VALUES (?, ?, ?)";

            psMalzeme = conn.prepareStatement(malzemeSql);

            for (String malzemeIdStr : secilenMalzemeler) {
                int malzemeId = Integer.parseInt(malzemeIdStr);

                String miktar = request.getParameter("miktar_" + malzemeId);

                if (miktar == null) {
                    miktar = "";
                }

                psMalzeme.setInt(1, tarifId);
                psMalzeme.setInt(2, malzemeId);
                psMalzeme.setString(3, miktar);

                psMalzeme.executeUpdate();
            }
        }

        response.sendRedirect("tarif_crud.jsp");

    } catch (Exception e) {
        out.println("<h3>Hata oluştu:</h3>");
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
        e.printStackTrace();

    } finally {
        if (generatedKeys != null) generatedKeys.close();
        if (psMalzeme != null) psMalzeme.close();
        if (psTarif != null) psTarif.close();
        if (conn != null) conn.close();
    }
%>