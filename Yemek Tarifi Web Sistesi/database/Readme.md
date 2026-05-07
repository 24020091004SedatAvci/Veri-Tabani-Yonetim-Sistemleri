# 🗄️ Yemek Tarifi - Veri Tabanı (Database)

Bu klasör, Yemek Tarifi uygulamasının çalışması için gereken ilişkisel veri tabanı tablolarını ve sistemin boş görünmemesi için eklenen örnek verileri (seed data) içermektedir.

## 📂 Dosya İçeriği

Bu klasördeki SQL dosyaları şu işlemleri gerçekleştirir:

1. **Şema Kurulumu (CREATE):** `yemek_tarifi` veri tabanını ve projenin iskeletini oluşturan 4 temel tabloyu oluşturur.
2. **Örnek Veriler (INSERT):** Temel kategorileri, 50'den fazla mutfak malzemesini ve test amaçlı birkaç temel yemek tarifini (Mercimek Çorbası, Tavuk Sote, Sütlaç vb.) içeri aktarır.

## 📊 Tablo Yapısı ve İlişkiler

Veri tabanı aşağıdaki ilişkisel tablolardan oluşmaktadır:

* **`kategoriler`:** Çorba, Ana Yemek, Tatlı gibi yemek gruplarını tutar.
* **`tarifler`:** Yemeklerin adı, hazırlanış adımları (açıklama), süresi ve fotoğraf URL'si gibi temel bilgileri barındırır. `kategoriler` tablosu ile ilişkilidir.
* **`malzemeler`:** Sistemde kullanılabilecek tüm malzemelerin (Tuz, Karabiber, Tavuk, Süt vb.) listesini tutar.
* **`tarif_malzemeleri`:** Bir tarifin içinde hangi malzemeden ne kadar kullanıldığını belirten **çoka-çok (many-to-many)** ilişki tablosudur.

## ⚙️ Nasıl Kurulur?

1. Veri tabanı yönetim aracınızı (Örn: phpMyAdmin, DBeaver, pgAdmin, SSMS) açın.
2. Önce **tablo oluşturma** sorgularını barındıran SQL dosyasını çalıştırın.
3. Tablolar oluştuktan sonra, **veri ekleme** (INSERT) sorgularını barındıran SQL dosyasını çalıştırarak veritabanınızı test verileriyle doldurun.