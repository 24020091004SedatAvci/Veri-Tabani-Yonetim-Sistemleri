# Yemek Tarifi - ASP.NET & MSSQL

Bu klasörde, Yemek Tarifi uygulamasının **ASP.NET Web Forms** ve **MSSQL (Microsoft SQL Server)** kullanılarak geliştirilmiş sürümü bulunmaktadır.

## Kullanılan Teknolojiler
* ASP.NET Web Forms (C#)
* MSSQL
* ADO.NET (Veri Tabanı Bağlantısı İçin)
* HTML / CSS / JavaScript

## Özellikler
* Tarif listeleme
* Tarif ekleme, güncelleme ve silme (CRUD)
* Tarif detay görüntüleme
* Malzeme seçme ve alışveriş listesi oluşturma

## Veri Tabanı
Veri tabanı oluşturma işlemleri için ana dizindeki `database.sql` dosyasını kullanabilirsiniz. 
* **Veri Tabanı Adı:** `yemek_tarifi`
* `kategoriler`
* `tarifler`
* `malzemeler`
* `tarif_malzemeleri`

## Kurulum ve Çalıştırma
1. SQL Server üzerinde `yemek_tarifi` adında bir veri tabanı oluşturun ve ana dizindeki `database.sql` dosyasındaki sorguları çalıştırarak tabloları ekleyin.
2. Projeyi **Visual Studio** üzerinden açın.
3. Proje içerisindeki `Web.config` dosyasını açın ve `<connectionStrings>` bölümündeki bağlantı ayarını (Data Source vb.) kendi SQL Server bilginize göre güncelleyin. (Eğer SQL Server Express kullanıyorsanız, `Data Source=.\SQLEXPRESS` olarak ayarlayabilirsiniz.)
4. Ana giriş sayfanızı (Örn: `Default.aspx`) başlangıç sayfası olarak ayarlayıp (Set as Start Page) projeyi çalıştırın (F5).

## Ekran Görüntüleri
Aşağıdaki bağlantılara tıklayarak projenin ekran görüntülerini inceleyebilirsiniz:

* [Ana Sayfa]
  <img width="1583" height="617" alt="asp-1" src="https://github.com/user-attachments/assets/61e91658-6484-4be5-9ca9-af5062eca27d" />

* [Tarif Yönetimi]
  <img width="1622" height="1034" alt="asp-2" src="https://github.com/user-attachments/assets/24f2db82-b3c9-490f-979b-187d38000b7b" />

* [Tarif Detay]
  <img width="1694" height="1038" alt="asp-3" src="https://github.com/user-attachments/assets/fb16dc14-54c9-44f6-b92e-b8aa078b30ca" />

* [Tarif Güncelleme]
  <img width="1519" height="628" alt="asp-4" src="https://github.com/user-attachments/assets/ace8e208-2615-494f-a7ee-61cd5729b360" />
