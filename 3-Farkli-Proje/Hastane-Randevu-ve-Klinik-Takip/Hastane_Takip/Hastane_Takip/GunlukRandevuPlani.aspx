<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GunlukRandevuPlani.aspx.cs" Inherits="Hastane_Takip.GunlukRandevuPlani" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Günlük Randevu Planı</title>
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

            <div class="page-head">
                <div class="section-title">
                    <h2>Günlük Randevu Planı</h2>
                    <p>
                        <asp:Literal ID="ltDoktorBilgi" runat="server"></asp:Literal>
                    </p>
                </div>

                <a href="Default.aspx" class="btn ghost">Kliniklere Dön</a>
            </div>

            <asp:Label 
                ID="lblMesaj" 
                runat="server" 
                Visible="false">
            </asp:Label>

            <div class="form-card search-card">

                <div class="form-section-title">
                    <h3>Tarih Seçimi</h3>
                    <p>Seçilen doktora ait günlük randevu planını görüntüleyebilirsiniz.</p>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Tarih</label>
                        <asp:TextBox 
                            ID="txtTarih" 
                            runat="server" 
                            TextMode="Date"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>

                    <div class="form-group button-group">
                        <label>&nbsp;</label>
                        <asp:Button 
                            ID="btnTarihGetir" 
                            runat="server" 
                            Text="Randevuları Getir" 
                            CssClass="btn primary"
                            OnClick="btnTarihGetir_Click" />
                    </div>
                </div>

            </div>

            <asp:Panel ID="pnlRandevuDuzenle" runat="server" Visible="false">

                <div class="form-card edit-card">

                    <div class="form-section-title">
                        <h3>Randevu Düzenle</h3>
                        <p>Randevu tarihi ve şikayet bilgisi güncellenebilir.</p>
                    </div>

                    <asp:HiddenField ID="hfRandevuID" runat="server" />

                    <div class="form-row">
                        <div class="form-group">
                            <label>Yeni Randevu Tarihi ve Saati</label>
                            <asp:TextBox 
                                ID="txtDuzenleRandevuTarihi" 
                                runat="server"
                                TextMode="DateTimeLocal"
                                CssClass="form-control">
                            </asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Şikayet</label>
                            <asp:TextBox 
                                ID="txtDuzenleSikayet" 
                                runat="server"
                                TextMode="MultiLine"
                                Rows="4"
                                CssClass="form-control">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button 
                            ID="btnRandevuGuncelle" 
                            runat="server" 
                            Text="Randevuyu Güncelle" 
                            CssClass="btn primary"
                            OnClick="btnRandevuGuncelle_Click" />

                        <asp:Button 
                            ID="btnRandevuIptal" 
                            runat="server" 
                            Text="Vazgeç" 
                            CssClass="btn ghost"
                            CausesValidation="false"
                            OnClick="btnRandevuIptal_Click" />
                    </div>

                </div>

            </asp:Panel>

            <asp:Panel ID="pnlRecete" runat="server" Visible="false">

                <div class="form-card edit-card">

                    <div class="form-section-title">
                        <h3>
                            <asp:Literal ID="ltReceteBaslik" runat="server"></asp:Literal>
                        </h3>
                        <p>Seçilen randevuya ait reçete bilgisi eklenebilir veya düzenlenebilir.</p>
                    </div>

                    <asp:HiddenField ID="hfReceteRandevuID" runat="server" />
                    <asp:HiddenField ID="hfReceteID" runat="server" />

                    <div class="form-row">
                        <div class="form-group">
                            <label>İlaç Listesi</label>
                            <asp:TextBox 
                                ID="txtIlacListesi" 
                                runat="server"
                                TextMode="MultiLine"
                                Rows="4"
                                CssClass="form-control">
                            </asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Kullanım Talimatı</label>
                            <asp:TextBox 
                                ID="txtKullanimTalimati" 
                                runat="server"
                                TextMode="MultiLine"
                                Rows="4"
                                CssClass="form-control">
                            </asp:TextBox>
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button 
                            ID="btnReceteKaydet" 
                            runat="server" 
                            Text="Reçeteyi Kaydet" 
                            CssClass="btn primary"
                            OnClick="btnReceteKaydet_Click" />

                        <asp:Button 
                            ID="btnReceteSil" 
                            runat="server" 
                            Text="Reçeteyi Sil" 
                            CssClass="btn danger"
                            Visible="false"
                            CausesValidation="false"
                            OnClick="btnReceteSil_Click" />

                        <asp:Button 
                            ID="btnReceteIptal" 
                            runat="server" 
                            Text="Vazgeç" 
                            CssClass="btn ghost"
                            CausesValidation="false"
                            OnClick="btnReceteIptal_Click" />
                    </div>

                </div>

            </asp:Panel>

            <div class="section-title">
                <h2>Randevu Listesi</h2>
                <p>Seçilen güne ait randevular aşağıda listelenmektedir.</p>
            </div>

            <div class="table-card">

                <asp:Repeater ID="rptRandevular" runat="server" OnItemCommand="rptRandevular_ItemCommand">
                    <HeaderTemplate>
                        <table>
                            <thead>
                                <tr>
                                    <th>Saat</th>
                                    <th>Hasta</th>
                                    <th>TC Kimlik</th>
                                    <th>Telefon</th>
                                    <th>Şikayet</th>
                                    <th>Reçete</th>
                                    <th>İşlemler</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("RandevuTarihi", "{0:HH:mm}") %></td>

                            <td>
                                <strong><%# Eval("HastaAdi") %></strong>
                                <br />
                                <a 
                                    class="mini-link" 
                                    href='HastaGecmisi.aspx?patientId=<%# Eval("HastaID") %>'>
                                    Hasta Geçmişi
                                </a>
                            </td>

                            <td><%# Eval("TCKimlik") %></td>
                            <td><%# Eval("Telefon") %></td>
                            <td><%# Eval("Sikayet") %></td>

                            <td>
                                <%# Convert.ToInt32(Eval("ReceteID")) > 0 ? "Yazıldı" : "Yazılmadı" %>
                            </td>

                            <td class="actions">
                                <asp:LinkButton 
                                    ID="btnDuzenle" 
                                    runat="server"
                                    Text="Düzenle"
                                    CssClass="btn small primary"
                                    CommandName="RandevuDuzenle"
                                    CommandArgument='<%# Eval("ID") %>'>
                                </asp:LinkButton>

                                <asp:LinkButton 
                                    ID="btnSil" 
                                    runat="server"
                                    Text="Sil"
                                    CssClass="btn small danger"
                                    CommandName="RandevuSil"
                                    CommandArgument='<%# Eval("ID") %>'
                                    OnClientClick="return confirm('Bu randevuyu silmek istediğine emin misin?');">
                                </asp:LinkButton>

                                <asp:LinkButton 
                                    ID="btnRecete" 
                                    runat="server"
                                    Text="Reçete"
                                    CssClass="btn small ghost"
                                    CommandName="ReceteIslem"
                                    CommandArgument='<%# Eval("ID") %>'>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

            </div>

        </main>

    </form>
</body>
</html>