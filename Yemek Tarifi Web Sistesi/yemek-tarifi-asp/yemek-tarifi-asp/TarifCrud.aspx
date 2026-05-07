<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TarifCrud.aspx.cs" Inherits="yemek_tarifi_asp.TarifCrud" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Tarif Yönetimi - ASP.NET</title>
    <link href="style.css" rel="stylesheet" />
</head>
<body>

<header class="site-header">
    <h1>Tarif Yönetimi</h1>
    <p>Tarif ekle, listele, sil ve malzeme seç.</p>
</header>

<form id="form1" runat="server">

    <div class="container">

        <div class="top-bar">
            <h2 class="page-title">Tarif Ekranı</h2>
            <a href="Default.aspx" class="btn btn-secondary">Ana Sayfa</a>
        </div>

        <h2 class="section-title">Tarif Listesi</h2>

        <div class="table-wrapper">
            <asp:GridView ID="gvTarifler" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="id"
                OnRowCommand="gvTarifler_RowCommand"
                CssClass="grid-table">

                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" />
                    <asp:BoundField DataField="tarif_adi" HeaderText="Tarif Adı" />
                    <asp:BoundField DataField="kategori_adi" HeaderText="Kategori" />
                    <asp:BoundField DataField="hazirlama_suresi" HeaderText="Süre" />

                    <asp:TemplateField HeaderText="İşlem">
                        <ItemTemplate>
                            <a class="btn btn-secondary" href='Detay.aspx?id=<%# Eval("id") %>'>
                                Detay
                            </a>

                            <a class="btn" href='Guncelle.aspx?id=<%# Eval("id") %>'>
                                Güncelle
                            </a>

                            <asp:LinkButton ID="btnSil" runat="server"
                                Text="Sil"
                                CssClass="btn btn-danger"
                                CommandName="Sil"
                                CommandArgument='<%# Eval("id") %>'
                                OnClientClick="return confirm('Bu tarifi silmek istediğinize emin misiniz?');">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
        </div>

        <h2 class="section-title">Yeni Tarif Ekle</h2>

        <div class="form-card">

            <div class="form-grid">

                <div class="form-group">
                    <label>Tarif Adı</label>
                    <asp:TextBox ID="txtTarifAdi" runat="server" placeholder="Örn: Tavuk Sote"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Kategori</label>
                    <asp:DropDownList ID="ddlKategori" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Hazırlama Süresi</label>
                    <asp:TextBox ID="txtSure" runat="server" TextMode="Number" placeholder="Örn: 45"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Fotoğraf URL</label>
                    <asp:TextBox ID="txtFoto" runat="server" placeholder="Örn: https://..."></asp:TextBox>
                </div>

                <div class="form-group full">
                    <label>Açıklama</label>
                    <asp:TextBox ID="txtAciklama" runat="server" TextMode="MultiLine" placeholder="Tarifin hazırlanışını yazınız..."></asp:TextBox>
                </div>

            </div>

            <h2 class="section-title">Malzeme Seçme</h2>

            <div class="material-search-box">
                <input type="text" id="malzemeArama" placeholder="Malzeme ara... Örn: tavuk, tuz, domates" onkeyup="malzemeAra()" />
            </div>

            <div class="table-wrapper">
                <asp:Repeater ID="rptMalzemeler" runat="server">
                    <HeaderTemplate>
                        <table id="malzemeTablosu" class="material-table">
                            <tr>
                                <th>Seç</th>
                                <th>Malzeme</th>
                                <th>Miktar</th>
                            </tr>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkMalzeme" runat="server" />
                                <asp:HiddenField ID="hfMalzemeId" runat="server" Value='<%# Eval("id") %>' />
                            </td>

                            <td class="malzeme-adi">
                                <%# Eval("malzeme_adi") %>
                            </td>

                            <td>
                                <asp:TextBox ID="txtMiktar" runat="server" placeholder="Örn: 1 adet, 500 gr, 2 kaşık"></asp:TextBox>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <br />

            <asp:Button ID="btnEkle" runat="server" Text="Tarifi Ekle" CssClass="btn" OnClick="btnEkle_Click" />

            <br /><br />

            <asp:Label ID="lblMesaj" runat="server"></asp:Label>

        </div>

    </div>

</form>

<script>
function malzemeAra() {
    let input = document.getElementById("malzemeArama");
    let filtre = input.value.toLocaleLowerCase("tr-TR");
    let tablo = document.getElementById("malzemeTablosu");

    if (!tablo) return;

    let satirlar = tablo.getElementsByTagName("tr");

    for (let i = 1; i < satirlar.length; i++) {
        let malzemeHucre = satirlar[i].getElementsByClassName("malzeme-adi")[0];

        if (malzemeHucre) {
            let malzemeAdi = malzemeHucre.textContent || malzemeHucre.innerText;
            malzemeAdi = malzemeAdi.toLocaleLowerCase("tr-TR");

            if (malzemeAdi.indexOf(filtre) > -1) {
                satirlar[i].style.display = "";
            } else {
                satirlar[i].style.display = "none";
            }
        }
    }
}
</script>

</body>
</html>