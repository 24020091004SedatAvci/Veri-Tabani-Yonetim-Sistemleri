<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doktor.aspx.cs" Inherits="Hastane_Takip.Doktor" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Doktor Seçimi</title>
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
                    <h2>
                        <asp:Literal ID="ltKlinikAdi" runat="server"></asp:Literal>
                    </h2>
                    <p>Seçilen kliniğe bağlı çalışan doktorlar listelenmektedir.</p>
                </div>

                <a href="Default.aspx" class="btn ghost">Kliniklere Dön</a>
            </div>

            <asp:Label 
                ID="lblMesaj" 
                runat="server" 
                CssClass="alert danger" 
                Visible="false">
            </asp:Label>

            <div class="doctor-grid">

                <asp:Repeater ID="rptDoctors" runat="server">
                    <ItemTemplate>
                        <div class="doctor-card">

                            <div class="doctor-icon">
                                👨‍⚕️
                            </div>

                            <h3><%# Eval("AdSoyad") %></h3>

                            <p>
                                <strong>Unvan:</strong>
                                <%# Eval("Unvan") %>
                            </p>

                            <p>
                                <strong>Klinik:</strong>
                                <%# Eval("KlinikAdi") %>
                            </p>

                            <p>
                                <strong>Kat No:</strong>
                                <%# Eval("KatNo") %>
                            </p>

                            <p>
                                <strong>Uzmanlık:</strong>
                                <%# Eval("Uzmanlik") %>
                            </p>

                            <div class="card-buttons">
                                <a 
                                    class="btn primary" 
                                    href='RandevuOlustur.aspx?doctorId=<%# Eval("ID") %>'>
                                    Randevu Al
                                </a>

                                <a 
                                    class="btn ghost" 
                                    href='GunlukRandevuPlani.aspx?docId=<%# Eval("ID") %>'>
                                    Günlük Plan
                                </a>
                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

        </main>

    </form>
</body>
</html>