# 📚 Veritabanı Yönetimi - Hafta 1 Ödevi

Bu depo, Kahramanmaraş İstiklal Üniversitesi Yazılım Mühendisliği bölümü Veritabanı Yönetimi dersi 1. hafta ödevini içermektedir. Proje kapsamında MySQL kullanılarak sıfırdan bir veritabanı tasarlanmış, tablo yapısı oluşturulmuş ve çeşitli veri kısıtlamaları (constraints) uygulanmıştır.

## 🚀 Proje İçeriği ve Öğrenim Çıktıları

Bu çalışmada temel SQL komutları (`CREATE`, `INSERT`, `SELECT`) kullanılarak aşağıdaki kısıtlamalar pratik edilmiştir:

- **PRIMARY KEY & AUTO_INCREMENT:** Her kaydın benzersiz bir kimliğe (`id`) sahip olması ve bu değerin otomatik artması sağlandı.
- **NOT NULL:** İsim, soyisim ve e-posta gibi kritik alanların boş geçilmesi engellendi.
- **CHECK:** Sisteme kayıt olacak kişilerin yaşının 18 veya daha büyük olması zorunluluğu getirildi.
- **DEFAULT CURRENT_TIMESTAMP:** Kayıt işleminin yapıldığı tarih ve saatin sisteme otomatik olarak işlenmesi sağlandı.

## 💻 Kullanılan SQL Sorguları

Aşağıdaki kodlar sırasıyla Workbench üzerinde çalıştırılarak veritabanı inşa edilmiştir:

### 1. Veritabanı ve Tablo Kurulumu
```sql
CREATE DATABASE kisilerim;
USE kisilerim;

CREATE TABLE kisiler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    eposta VARCHAR(50) NOT NULL,
    yas INT CHECK (yas >= 18),
    kayit_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

2. Tabloya Veri Ekleme (INSERT)

```sql
INSERT INTO kisiler (ad, soyad, eposta, yas) 
VALUES 
    ('Ayşe', 'Demir', 'ayse.demir@ornek.com', 24),
    ('Mehmet', 'Kaya', 'mehmet.kaya@ornek.com', 35);
```

3. Verileri Okuma (SELECT)

```sql
SELECT * FROM kisiler;
```


Örnek Sorgu Çıktısı

id,ad,soyad,eposta,yas,kayit_tarihi

1,Ayşe,Demir,ayse.demir@ornek.com,24,2026-02-26 16:40:00

2,Mehmet,Kaya,mehmet.kaya@ornek.com,35,2026-02-26 16:40:00



