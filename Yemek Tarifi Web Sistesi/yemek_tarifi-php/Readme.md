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

* [Ana Sayfa]
* <img width="1573" height="712" alt="php-1" src="https://github.com/user-attachments/assets/8c01b569-a73b-403f-894b-a3342559eb59" />

* [Tarif Yönetimi]
* <img width="1640" height="997" alt="php-2" src="https://github.com/user-attachments/assets/dc854652-0e59-4535-824e-5a58c672f7c0" />

* [Tarif Detay]
* <img width="1536" height="1066" alt="php-3" src="https://github.com/user-attachments/assets/06faaf79-bd8d-44ac-9fa2-0285eb72f5d1" />

* [Tarif Güncelleme]
* <img width="1568" height="527" alt="php-4" src="https://github.com/user-attachments/assets/acbce808-86db-42fe-8d8f-475cfc6ee99b" />
