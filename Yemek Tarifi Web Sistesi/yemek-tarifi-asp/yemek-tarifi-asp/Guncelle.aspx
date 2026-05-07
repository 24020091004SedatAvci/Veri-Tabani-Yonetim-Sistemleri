<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Guncelle.aspx.cs" Inherits="yemek_tarifi_asp.Guncelle" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Tarif Güncelle - ASP.NET</title>
    <link href="style.css" rel="stylesheet" />
</head>
<body>

<header class="site-header">
    <h1>Tarif Güncelle</h1>
    <p>Seçilen tarifin bilgilerini düzenle.</p>
</header>

<form id="form1" runat="server">

    <div class="container">

        <div class="top-bar">
            <h2 class="page-title">Tarif Düzenleme</h2>

            <div>
                <a href="Default.aspx" class="btn btn-secondary">Ana Sayfa</a>
                <a href="TarifCrud.aspx" class="btn">Tarif Yönetimi</a>
            </div>
        </div>

        <div class="form-card">

            <asp:HiddenField ID="hfId" runat="server" />

            <div class="form-grid">

                <div class="form-group">
                    <label>Tarif Adı</label>
                    <asp:TextBox ID="txtTarifAdi" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Kategori</label>
                    <asp:DropDownList ID="ddlKategori" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Hazırlama Süresi</label>
                    <asp:TextBox ID="txtSure" runat="server" TextMode="Number"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Fotoğraf URL</label>
                    <asp:TextBox ID="txtFoto" runat="server"></asp:TextBox>
                </div>

                <div class="form-group full">
                    <label>Açıklama</label>
                    <asp:TextBox ID="txtAciklama" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>

            </div>

            <br />

            <asp:Button ID="btnGuncelle" runat="server" Text="Güncelle" CssClass="btn" OnClick="btnGuncelle_Click" />

            <br /><br />

            <asp:Label ID="lblMesaj" runat="server"></asp:Label>

        </div>

    </div>

</form>

</body>
</html>