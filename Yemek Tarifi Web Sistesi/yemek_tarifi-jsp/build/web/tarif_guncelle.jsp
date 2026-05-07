<%-- 
    Document   : tarifi_guncelle
    Created on : 7 May 2026, 18:53:02
    Author     : Sedat
--%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String kategoriId = request.getParameter("kategori_id");
    String tarifAdi = request.getParameter("tarif_adi");
    String aciklama = request.getParameter("aciklama");
    String hazirlamaSuresi = request.getParameter("hazirlama_suresi");
    String fotografUrl = request.getParameter("fotograf_url");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = DBConnection.getConnection();

        String sql = "UPDATE tarifler SET " +
                     "kategori_id = ?, " +
                     "tarif_adi = ?, " +
                     "aciklama = ?, " +
                     "hazirlama_suresi = ?, " +
                     "fotograf_url = ? " +
                     "WHERE id = ?";

        ps = conn.prepareStatement(sql);

        ps.setInt(1, Integer.parseInt(kategoriId));
        ps.setString(2, tarifAdi);
        ps.setString(3, aciklama);
        ps.setInt(4, Integer.parseInt(hazirlamaSuresi));
        ps.setString(5, fotografUrl);
        ps.setInt(6, Integer.parseInt(id));

        ps.executeUpdate();

        response.sendRedirect("tarif_crud.jsp");

    } catch (Exception e) {
        out.println("<h3>Güncelleme sırasında hata oluştu:</h3>");
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
        e.printStackTrace();

    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>