<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SepetUyg_asp.WebForm1" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sepet Uygulaması - ASP.NET</title>
    <style>
        body { background-color: #6f5fba; color: white; font-family: 'Segoe UI', sans-serif; text-align: center; margin: 0; padding: 20px; }
        .container { width: 95%; max-width: 1100px; margin: auto; background: #8e82cf; padding: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { margin-bottom: 25px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
        
        .grid-style { width: 100%; background: white; color: black; border-collapse: collapse; margin-top: 15px; border-radius: 10px; overflow: hidden; }
        .grid-style th { background: #f4f4f4; color: #333; padding: 12px; }
        .grid-style td { padding: 12px; border: 1px solid #ddd; text-align: center; }
        
        /* Seçili Satır (Sarı Parlama) */
        .selected-row { background-color: #ffff00 !important; font-weight: bold; color: black !important; }

        .form-area { background: rgba(255,255,255,0.15); padding: 20px; border-radius: 10px; margin-bottom: 25px; }
        input, select, .asp-button { padding: 10px; margin: 5px; border-radius: 6px; border: 1px solid #ccc; }
        .btn-m-ekle { background-color: #4CAF50; color: white; border: none; cursor: pointer; font-weight: bold; }
        .btn-u-ekle { background-color: #2196F3; color: white; border: none; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Sepet Uygulaması</h1>

            <div class="form-area">
                <asp:TextBox ID="txtMusteriAdi" runat="server" placeholder="Müşteri Adı"></asp:TextBox>
                <asp:DropDownList ID="ddlDurum" runat="server">
                    <asp:ListItem Text="Aktif" Value="Aktif"></asp:ListItem>
                    <asp:ListItem Text="İptal" Value="İptal"></asp:ListItem>
                    <asp:ListItem Text="Tamamlandı" Value="Tamamlandı"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnMusteriEkle" runat="server" Text="Müşteriyi Sepete Ekle" CssClass="asp-button btn-m-ekle" OnClick="btnMusteriEkle_Click" />
            </div>

            <!-- MÜŞTERİ TABLOSU: RowDataBound ile tıklama özelliği eklendi -->
            <asp:GridView ID="gvMusteriler" runat="server" AutoGenerateColumns="False" CssClass="grid-style" 
                 DataKeyNames="müsteri_id" OnSelectedIndexChanged="gvMusteriler_SelectedIndexChanged" OnRowDataBound="gvMusteriler_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="müsteri_id" HeaderText="ID" />
                    <asp:BoundField DataField="müsteri_adi" HeaderText="Müşteri Adı" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />
                    <asp:TemplateField HeaderText="İşlem">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnSil" runat="server" Text="Sil" ForeColor="Red" OnClick="btnMusteriSil_Click" 
                                CommandArgument='<%# Eval("müsteri_id") %>' OnClientClick="return confirm('Müşteriyi ve sepetini silmek istediğine emin misin?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle CssClass="selected-row" />
            </asp:GridView>

            <br /><hr style="border: 0.5px solid rgba(255,255,255,0.3);"/><br />

            <asp:Panel ID="pnlSepet" runat="server" Visible="false">
                <h2 style="text-align: left;">Müşteri Sepet Detayı</h2>
                <div class="form-area">
                    <asp:TextBox ID="txtUrunAdi" runat="server" placeholder="Ürün Adı"></asp:TextBox>
                    <asp:TextBox ID="txtFiyat" runat="server" placeholder="Fiyat (TL)" TextMode="Number"></asp:TextBox>
                    <asp:TextBox ID="txtAdet" runat="server" placeholder="Adet" TextMode="Number"></asp:TextBox>
                    <asp:Button ID="btnUrunEkle" runat="server" Text="Ürünü Sepete At" CssClass="asp-button btn-u-ekle" OnClick="btnUrunEkle_Click" />
                </div>

                <!-- SEPET TABLOSU: Ürün Silme eklendi -->
                <asp:GridView ID="gvSepet" runat="server" AutoGenerateColumns="False" CssClass="grid-style">
                    <Columns>
                        <asp:BoundField DataField="ürün_id" HeaderText="No" />
                        <asp:BoundField DataField="ürün_adi" HeaderText="Ürün İsmi" />
                        <asp:BoundField DataField="fiyat" HeaderText="Fiyat (TL)" DataFormatString="{0:N2} TL" />
                        <asp:BoundField DataField="adet" HeaderText="Miktar" />
                        <asp:TemplateField HeaderText="İşlem">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnUrunSil" runat="server" Text="Ürünü Sil" ForeColor="DarkRed" 
                                    OnClick="btnUrunSil_Click" CommandArgument='<%# Eval("ürün_id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </div>
    </form>
</body>
</html>