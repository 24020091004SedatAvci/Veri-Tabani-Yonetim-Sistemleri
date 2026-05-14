<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RandevuOlustur.aspx.cs" Inherits="Hastane_Takip.RandevuOlustur" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Randevu Oluştur</title>
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
                    <h2>Randevu Oluştur</h2>
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

            <div class="form-card">

                <div class="form-section-title">
                    <h3>Hasta Bilgileri</h3>
                    <p>
                        Hasta daha önce kayıtlıysa TC kimlik numarası üzerinden bulunur.
                        Kayıtlı değilse hasta bilgileri yeni kayıt olarak eklenir.
                    </p>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>TC Kimlik</label>
                        <asp:TextBox 
                            ID="txtTCKimlik" 
                            runat="server" 
                            MaxLength="11"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Ad Soyad</label>
                        <asp:TextBox 
                            ID="txtHastaAdSoyad" 
                            runat="server"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Telefon</label>
                        <asp:TextBox 
                            ID="txtTelefon" 
                            runat="server"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Kan Grubu</label>
                        <asp:DropDownList 
                            ID="ddlKanGrubu" 
                            runat="server"
                            CssClass="form-control">
                            <asp:ListItem Text="A+" Value="A+" />
                            <asp:ListItem Text="A-" Value="A-" />
                            <asp:ListItem Text="B+" Value="B+" />
                            <asp:ListItem Text="B-" Value="B-" />
                            <asp:ListItem Text="AB+" Value="AB+" />
                            <asp:ListItem Text="AB-" Value="AB-" />
                            <asp:ListItem Text="0+" Value="0+" />
                            <asp:ListItem Text="0-" Value="0-" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-section-title">
                    <h3>Randevu Bilgileri</h3>
                    <p>
                        Aynı doktora aynı tarih ve saatte ikinci randevu oluşturulamaz.
                    </p>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Randevu Tarihi ve Saati</label>
                        <asp:TextBox 
                            ID="txtRandevuTarihi" 
                            runat="server"
                            TextMode="DateTimeLocal"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Şikayet</label>
                        <asp:TextBox 
                            ID="txtSikayet" 
                            runat="server"
                            TextMode="MultiLine"
                            Rows="4"
                            CssClass="form-control">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="form-actions">
                    <asp:Button 
                        ID="btnKaydet" 
                        runat="server" 
                        Text="Randevu Oluştur" 
                        CssClass="btn primary" 
                        OnClick="btnKaydet_Click" />

                    <a href="Default.aspx" class="btn ghost">Vazgeç</a>
                </div>

            </div>

        </main>

    </form>
</body>
</html>