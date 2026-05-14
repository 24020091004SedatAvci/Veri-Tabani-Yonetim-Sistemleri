<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HastaGecmisi.aspx.cs" Inherits="Hastane_Takip.HastaGecmisi" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Hasta Geçmişi</title>
    <link rel="stylesheet" href="style.css?v=1" />
</head>
<body>
    <form id="form1" runat="server">

        <header class="navbar">
            <div class="logo">Hastane Takip</div>

            <nav>
                <a href="Default.aspx">Klinikler</a>
                <a href="HastaGecmisi.aspx">Hasta Geçmişi</a>
            </nav>
        </header>

        <main class="container">

            <div class="section-title">
                <h2>Hasta Geçmişi</h2>
                <p>Hastanın geçmiş randevularını ve varsa reçete bilgilerini görüntüleyebilirsiniz.</p>
            </div>

            <asp:Label 
                ID="lblMesaj" 
                runat="server" 
                Visible="false">
            </asp:Label>

            <div class="form-card search-card">

                <div class="form-section-title">
                    <h3>Hasta Arama</h3>
                    <p>Hasta geçmişini görüntülemek için TC kimlik numarası giriniz.</p>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>TC Kimlik</label>
                        <asp:TextBox 
                            ID="txtTCKimlikAra" 
                            runat="server" 
                            MaxLength="11"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>

                    <div class="form-group button-group">
                        <label>&nbsp;</label>
                        <asp:Button 
                            ID="btnAra" 
                            runat="server" 
                            Text="Geçmişi Getir" 
                            CssClass="btn primary"
                            OnClick="btnAra_Click" />
                    </div>
                </div>

            </div>

            <asp:Panel ID="pnlHastaBilgi" runat="server" Visible="false">

                <div class="patient-info-card">
                    <h3>
                        <asp:Literal ID="ltHastaAdSoyad" runat="server"></asp:Literal>
                    </h3>

                    <p>
                        <strong>TC Kimlik:</strong>
                        <asp:Literal ID="ltTCKimlik" runat="server"></asp:Literal>
                    </p>

                    <p>
                        <strong>Telefon:</strong>
                        <asp:Literal ID="ltTelefon" runat="server"></asp:Literal>
                    </p>

                    <p>
                        <strong>Kan Grubu:</strong>
                        <asp:Literal ID="ltKanGrubu" runat="server"></asp:Literal>
                    </p>
                </div>

                <div class="section-title">
                    <h2>Randevu ve Reçete Kayıtları</h2>
                    <p>Hastaya ait tüm geçmiş randevular aşağıda listelenmektedir.</p>
                </div>

                <div class="table-card">
                    <asp:Repeater ID="rptGecmis" runat="server">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Randevu Tarihi</th>
                                        <th>Klinik</th>
                                        <th>Doktor</th>
                                        <th>Şikayet</th>
                                        <th>İlaç Listesi</th>
                                        <th>Kullanım Talimatı</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("RandevuTarihi", "{0:dd.MM.yyyy HH:mm}") %></td>
                                <td><%# Eval("KlinikAdi") %></td>
                                <td><%# Eval("Unvan") %> <%# Eval("DoktorAdi") %></td>
                                <td><%# Eval("Sikayet") %></td>
                                <td>
                                    <%# string.IsNullOrEmpty(Eval("IlacListesi").ToString()) ? "Reçete yok" : Eval("IlacListesi") %>
                                </td>
                                <td>
                                    <%# string.IsNullOrEmpty(Eval("KullanimTalimati").ToString()) ? "Reçete yok" : Eval("KullanimTalimati") %>
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>

            </asp:Panel>

        </main>

    </form>
</body>
</html>