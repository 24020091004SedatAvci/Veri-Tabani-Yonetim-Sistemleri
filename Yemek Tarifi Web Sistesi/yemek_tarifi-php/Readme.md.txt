# Yemek Tarifi - PHP & MySQL

Bu klasörde, Yemek Tarifi uygulamasının **PHP** ve **MySQL** kullanılarak geliştirilmiş sürümü bulunmaktadır.

## Kullanılan Teknolojiler
* PHP
* MySQL
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
1. Projeyi XAMPP, WAMP veya benzeri bir yerel sunucunun kök dizinine kopyalayın (Örn: `C:\xampp\htdocs\yemek_tarifi-php` veya `C:\wamp64\www\yemek_tarifi-php`).
2. Veri tabanı sunucunuzu (MySQL) başlatın, `yemek_tarifi` adında bir veri tabanı oluşturun ve ana dizindeki `database.sql` dosyasını içe aktarın.
3. Gerekirse `baglanti.php` (veya veritabanı bağlantı dosyanızın adı neyse) içindeki kullanıcı adı ve şifre bilgilerini kendi yerel sunucunuza göre düzenleyin.
4. Tarayıcınızdan `http://localhost/yemek_tarifi-php/` adresine giderek projeyi çalıştırın.

## Ekran Görüntüleri
Aşağıdaki bağlantılara tıklayarak projenin ekran görüntülerini inceleyebilirsiniz:

* [Ana Sayfa](./screenshots/ana_sayfa.png)
* [Tarif Yönetimi](./screenshots/tarif_yonetimi.png)
* [Tarif Detay](./screenshots/detay.png)
* [Tarif Güncelleme](./screenshots/guncelle.png)