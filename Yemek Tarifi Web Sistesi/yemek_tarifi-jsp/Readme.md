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

* [Ana Sayfa](./screenshots/ana_sayfa.png)
* [Tarif Yönetimi](./screenshots/tarif_yonetimi.png)
* [Tarif Detay](./screenshots/detay.png)
* [Tarif Güncelleme](./screenshots/guncelle.png)