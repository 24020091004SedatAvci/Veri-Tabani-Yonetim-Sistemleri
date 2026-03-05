# 🎓 Okul Veritabanı Sistemi ve SQL Temelleri

Bu proje, ilişkisel veritabanı yönetim sistemlerinin (RDBMS) temellerini pratik etmek amacıyla **WampServer** ve **MariaDB** kullanılarak sıfırdan geliştirilmiş uygulamalı bir SQL projesidir. Kahramanmaraş İstiklal Üniversitesi Yazılım Mühendisliği bölümü çalışmaları kapsamında, teorik veritabanı bilgilerini gerçekçi senaryolarla kodlara dökmek için hazırlanmıştır.

Proje, W3Schools SQL müfredatı takip edilerek adım adım inşa edilmiş olup, baştan sona tüm sürecin anlatıldığı bir [YouTube Eğitim Videosu](VİDEO_LİNKİNİ_BURAYA_YAPIŞTIR) ile desteklenmiştir.

## 🛠️ Kullanılan Teknolojiler
* **Sunucu Altyapısı:** WampServer (Localhost)
* **Veritabanı Motoru:** MariaDB / MySQL
* **Sorgu Dili:** SQL
* **Araçlar:** phpMyAdmin, Komut Satırı (CLI)

## 📂 Proje İçeriği ve İşlenen Konular
Proje kapsamında `okul_db` adında bir veritabanı tasarlanmış, içerisine öğrencilerin vize/final notları ve ders bilgilerini içeren tablolar eklenerek aşağıdaki SQL operasyonları uygulanmıştır:

- **DDL (Data Definition Language):** Veritabanı ve tablo oluşturma (`CREATE`)
- **DML (Data Manipulation Language):** Veri ekleme, güncelleme, silme (`INSERT`, `UPDATE`, `DELETE`)
- **Filtreleme ve Arama İşlemleri:** `WHERE`, `LIKE`, `IN`, `BETWEEN`
- **Sıralama ve Kısıtlama:** `ORDER BY`, `LIMIT`
- **Matematiksel Fonksiyonlar (Aggregate):** `MIN`, `MAX`, `COUNT`, `AVG`, `SUM`
- **İlişkisel Veri Çekme:** `INNER JOIN` (Öğrenci notları ve ders isimlerinin birleştirilmesi)

## 📁 Repository Dosya Yapısı
* `okul_db.sql`: Veritabanının oluşturulmuş tablolara ve örnek verilere sahip tam yedeği (Dışa aktarılmış hali).
* `sorgular.sql`: Projede kullanılan tüm SQL sorgularının sırasıyla derlendiği ve yorum satırlarıyla açıklandığı ana kod dosyası.

## 📊 Örnek Çıktılar (Outputs)
Aşağıda, proje kapsamında çalıştırılan bazı kritik SQL sorgularının veritabanı üzerindeki canlı çıktılarını görebilirsiniz:

**1. Tablo Birleştirme (INNER JOIN) Çıktısı**
> Öğrencilerin ID'ler üzerinden eşleşerek aldıkları derslerin isimleriyle birlikte listelenmesi.
![INNER JOIN Sonucu](images/join_resminin_adini_yaz.png)

**2. Veri Filtreleme ve Not Ortalaması (AVG / WHERE) Çıktısı**
> Sınıfın final notu ortalaması ve belirli bir not aralığındaki öğrencilerin filtrelenmesi.
![AVG ve Filtreleme Sonucu](images/avg_resminin_adini_yaz.png)

*(Not: Bu projeyi kendi bilgisayarınızda test etmek için `okul_db.sql` dosyasını localhost'unuza import edebilir ve `sorgular.sql` içindeki komutları çalıştırabilirsiniz.)*