<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Hastane_Takip._Default" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Hastane Randevu ve Klinik Takip</title>
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

        <section class="hero">
            <div>
                <h1>Hastane Randevu ve Klinik Takip Sistemi</h1>
                <p>
                    Hastanedeki klinikleri görüntüleyebilir, seçilen kliniğe bağlı doktorları listeleyebilir
                    ve uygun doktora randevu oluşturabilirsiniz.
                </p>
            </div>
        </section>

        <main class="container">

            <div class="section-title">
                <h2>Klinik Listesi</h2>
                <p>Hastanedeki birimler ve uzmanlık alanları aşağıda listelenmektedir.</p>
            </div>

            <asp:Label 
                ID="lblMesaj" 
                runat="server" 
                CssClass="alert danger" 
                Visible="false">
            </asp:Label>

            <div class="clinic-grid">
                <asp:Repeater ID="rptClinics" runat="server">
                    <ItemTemplate>
                        <div class="clinic-card">
                            <div class="clinic-icon">
                                🏥
                            </div>

                            <div class="clinic-content">
                                <h3><%# Eval("KlinikAdi") %></h3>

                                <p>
                                    <strong>Uzmanlık:</strong>
                                    <%# Eval("Uzmanlik") %>
                                </p>

                                <p>
                                    <strong>Kat No:</strong>
                                    <%# Eval("KatNo") %>
                                </p>

                                <a 
                                    class="btn primary full" 
                                    href='Doktor.aspx?clinicId=<%# Eval("ID") %>'>
                                    Doktorları Gör
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