<%-- 
    Document   : tarifi_sil
    Created on : 7 May 2026, 18:48:44
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
    PreparedStatement ps = null;

    try {
        conn = DBConnection.getConnection();

        String sql = "DELETE FROM tarifler WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(idParam));

        ps.executeUpdate();

        response.sendRedirect("tarif_crud.jsp");

    } catch (Exception e) {
        out.println("<h3>Silme işlemi sırasında hata oluştu:</h3>");
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
        e.printStackTrace();

    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>