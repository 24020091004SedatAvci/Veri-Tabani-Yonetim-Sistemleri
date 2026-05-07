# Yemek Tarifi - JSP & PostgreSQL

Bu klasörde, Yemek Tarifi uygulamasının **JSP (Java Server Pages)** ve **PostgreSQL** kullanılarak geliştirilmiş sürümü bulunmaktadır.

## Kullanılan Teknolojiler
* Java & JSP
* PostgreSQL
* JDBC (Veri Tabanı Bağlantısı İçin)
* Apache Tomcat (Sunucu)
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
1. PostgreSQL sunucunuzda `yemek_tarifi` adında bir veri tabanı oluşturun ve ana dizindeki `database.sql` dosyasındaki sorguları çalıştırarak tabloları ekleyin.
2. Projenin veri tabanına bağlanabilmesi için PostgreSQL JDBC sürücüsünün (Örn: `postgresql-42.x.x.jar`) projenizin kütüphanelerine (lib klasörüne) eklendiğinden emin olun.
3. `DBConnection.java` (veya bağlantıyı sağladığınız dosya) içindeki veri tabanı kullanıcı adı ve şifre bilgilerinizi kendi PostgreSQL ayarlarınıza göre güncelleyin.
4. Projeyi Eclipse, IntelliJ IDEA veya benzeri bir IDE üzerinden **Apache Tomcat** sunucusunda çalıştırın (Örn: `http://localhost:8080/yemek_tarifi-jsp/`).

## Ekran Görüntüleri
Aşağıdaki bağlantılara tıklayarak projenin ekran görüntülerini inceleyebilirsiniz:

* [Ana Sayfa]
  <img width="1409" height="521" alt="jsp-2" src="https://github.com/user-attachments/assets/31f79ba6-d56e-4a96-877b-d1c8be2362e4" />

* [Tarif Yönetimi]
  <img width="1663" height="1050" alt="jsp-3" src="https://github.com/user-attachments/assets/8d83fe93-2565-4fcf-b1a3-d14265cb3b4c" />

* [Tarif Detay]
  <img width="1919" height="1060" alt="jsp-1" src="https://github.com/user-attachments/assets/3c1f45d1-a932-4ef6-bd70-07e864227c47" />

* [Tarif Güncelleme]
  <img width="1581" height="625" alt="jsp-4" src="https://github.com/user-attachments/assets/ebb54549-4c9f-4500-ab96-9a9a6ddeb4b1" />
