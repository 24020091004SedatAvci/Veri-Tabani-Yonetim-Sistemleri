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

Kullanılan tablolar:
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

* [Ana Sayfa](./screenshots/ana_sayfa.png)
* [Tarif Yönetimi](./screenshots/tarif_yonetimi.png)
* [Tarif Detay](./screenshots/detay.png)
* [Tarif Güncelleme](./screenshots/guncelle.png)