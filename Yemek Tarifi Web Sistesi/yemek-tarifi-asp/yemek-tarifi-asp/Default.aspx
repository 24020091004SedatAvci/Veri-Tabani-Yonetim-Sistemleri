<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="yemek_tarifi_asp.Default" %>
<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Yemek Tarifi Sitesi - ASP.NET</title>
    <link href="style.css" rel="stylesheet" />
</head>
<body>

<header class="site-header">
    <h1>Yemek Tarifi Sitesi</h1>
    <p>ASP.NET ve MSSQL ile geliştirilmiş yemek tarifi uygulaması.</p>
</header>

<form id="form1" runat="server">
    <div class="container">

        <div class="top-bar">
            <h2 class="page-title">Tarifler</h2>
            <a href="TarifCrud.aspx" class="btn">+ Yeni Tarif Ekle</a>
        </div>

        <div class="card-list">
            <asp:Repeater ID="rptTarifler" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <img src='<%# Eval("fotograf_url") == DBNull.Value || Eval("fotograf_url").ToString() == "" ? "https://images.unsplash.com/photo-1547592166-23ac45744acd" : Eval("fotograf_url") %>' alt="Yemek Fotoğrafı" />

                        <div class="card-body">
                            <h3><%# Eval("tarif_adi") %></h3>
                            <p><b>Kategori:</b> <%# Eval("kategori_adi") %></p>
                            <p><b>Hazırlama Süresi:</b> <%# Eval("hazirlama_suresi") %> dk</p>

                            <a class="btn" href='Detay.aspx?id=<%# Eval("id") %>'>
                                Detay Gör
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Panel ID="pnlBos" runat="server" Visible="false" CssClass="empty-message">
            Henüz tarif eklenmemiş.
        </asp:Panel>

    </div>
</form>

</body>
</html>
