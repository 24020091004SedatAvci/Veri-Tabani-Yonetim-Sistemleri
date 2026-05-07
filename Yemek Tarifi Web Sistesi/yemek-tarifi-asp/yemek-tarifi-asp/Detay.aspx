<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detay.aspx.cs" Inherits="yemek_tarifi_asp.Detay" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Tarif Detay - ASP.NET</title>
    <link href="style.css" rel="stylesheet" />
</head>
<body>

<header class="site-header">
    <h1>Tarif Detay</h1>
    <p>Seçilen yemeğin bilgileri ve alışveriş listesi.</p>
</header>

<form id="form1" runat="server">

    <div class="container">

        <div class="top-bar">
            <h2 class="page-title">
                <asp:Label ID="lblBaslik" runat="server"></asp:Label>
            </h2>

            <div>
                <a href="Default.aspx" class="btn btn-secondary">Ana Sayfa</a>
                <a href="TarifCrud.aspx" class="btn">Tarif Yönetimi</a>
            </div>
        </div>

        <div class="detail-box">
            <div>
                <asp:Image ID="imgTarif" runat="server" AlternateText="Yemek Fotoğrafı" />
            </div>

            <div class="detail-content">
                <h2>
                    <asp:Label ID="lblTarifAdi" runat="server"></asp:Label>
                </h2>

                <span class="badge">
                    Kategori:
                    <asp:Label ID="lblKategori" runat="server"></asp:Label>
                </span>

                <span class="badge">
                    Süre:
                    <asp:Label ID="lblSure" runat="server"></asp:Label>
                    dk
                </span>

                <h3>Tarif Açıklaması</h3>

                <asp:Label ID="lblAciklama" runat="server" CssClass="recipe-description"></asp:Label>
            </div>
        </div>

        <h2 class="section-title">Alışveriş Listesi</h2>

        <div class="table-wrapper">
            <asp:GridView ID="gvMalzemeler" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid-table">

                <Columns>
                    <asp:BoundField DataField="malzeme_adi" HeaderText="Malzeme" />
                    <asp:BoundField DataField="miktar" HeaderText="Miktar" />
                </Columns>

            </asp:GridView>
        </div>

        <asp:Panel ID="pnlMalzemeYok" runat="server" Visible="false" CssClass="empty-message">
            Bu tarif için henüz malzeme eklenmemiş.
        </asp:Panel>

    </div>

</form>

</body>
</html>