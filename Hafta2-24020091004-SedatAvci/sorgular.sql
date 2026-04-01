-- =======================================================
-- PROJE: OKUL VERİTABANI SİSTEMİ (W3SCHOOLS SQL MÜFREDATI)
-- =======================================================

-- 1. Veritabanı ve Tablo Kurulumu
CREATE DATABASE IF NOT EXISTS okul_db;
USE okul_db;

CREATE TABLE IF NOT EXISTS dersler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ders_adi VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS ogrenciler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad_soyad VARCHAR(50),
    sehir VARCHAR(50),
    vize_notu INT,
    final_notu INT,
    ders_id INT
);

-- 2. Örnek Verilerin Eklenmesi
INSERT INTO dersler (ders_adi) VALUES 
('Nesne Yönelimli Programlama'), 
('Veri Yapıları'), 
('Ayrık Matematik');

INSERT INTO ogrenciler (ad_soyad, sehir, vize_notu, final_notu, ders_id) VALUES
('Sedat Avcı', 'Mersin', 75, 85, 1),
('Muhammed Yusuf Nahırcı', 'Hatay', 90, 95, 1),
('Enes Mangü', 'İzmir', 40, 50, 2),
('Ali Fatih Arslan', 'Çorum', NULL, NULL, 3),
('Hüseyin Gildir', 'Adana', 85, 90, 2),
('Elif Şahin', 'İstanbul', 60, 70, 1);


-- =======================================================
-- UYGULAMALI SQL SORGULARI
-- =======================================================

-- SQL SELECT: Tüm tabloyu listeleme
SELECT * FROM ogrenciler;

-- SQL SELECT DISTINCT: Benzersiz şehirleri listeleme
SELECT DISTINCT sehir FROM ogrenciler;

-- SQL WHERE: Belirli bir şehre göre filtreleme (Hatay)
SELECT * FROM ogrenciler WHERE sehir = 'Hatay';

-- SQL AND: İki koşulun da sağlandığı durumu bulma
SELECT * FROM ogrenciler WHERE ders_id = 1 AND final_notu > 80;

-- SQL OR: Koşullardan en az birinin sağlandığı durumu bulma
SELECT * FROM ogrenciler WHERE sehir = 'Mersin' OR vize_notu > 80;

-- SQL ORDER BY: Final notuna göre azalan (büyükten küçüğe) sıralama
SELECT * FROM ogrenciler ORDER BY final_notu DESC;

-- SQL INSERT INTO: Tabloya yeni bir öğrenci ekleme
INSERT INTO ogrenciler (ad_soyad, sehir, vize_notu, final_notu, ders_id) 
VALUES ('Burak Can', 'Antalya', 80, 88, 1);

-- SQL NULL Values: Notu girilmemiş (NULL) olan öğrencileri bulma
SELECT * FROM ogrenciler WHERE final_notu IS NULL;

-- SQL UPDATE: Bir öğrencinin notunu güncelleme
UPDATE ogrenciler SET final_notu = 100 WHERE ad_soyad = 'Sedat Avcı';

-- SQL DELETE: Tablodan bir öğrencinin kaydını silme
DELETE FROM ogrenciler WHERE ad_soyad = 'Enes Mangü';

-- SQL LIMIT: En yüksek final notuna sahip ilk 3 öğrenciyi getirme
SELECT * FROM ogrenciler ORDER BY final_notu DESC LIMIT 3;

-- SQL MIN / MAX: Sınıftaki en yüksek final notunu bulma
SELECT MAX(final_notu) FROM ogrenciler;

-- SQL AVG: Sınıfın final notu ortalamasını hesaplama
SELECT AVG(final_notu) FROM ogrenciler;

-- SQL LIKE: İsmi 'E' harfi ile başlayan öğrencileri bulma
SELECT * FROM ogrenciler WHERE ad_soyad LIKE 'E%';

-- SQL IN: Sadece belirli şehirlerden olanları getirme
SELECT * FROM ogrenciler WHERE sehir IN ('Mersin', 'Adana');

-- SQL BETWEEN: Final notu 60 ile 85 arasında olanları bulma
SELECT * FROM ogrenciler WHERE final_notu BETWEEN 60 AND 85;

-- SQL ALIASES: Sütun isimlerini daha okunaklı hale getirme
SELECT ad_soyad AS 'Öğrenci Adı', final_notu AS 'Yıl Sonu Notu' FROM ogrenciler;

-- SQL INNER JOIN: Öğrenci tablosu ile ders tablosunu ID üzerinden birleştirme
SELECT ogrenciler.ad_soyad, dersler.ders_adi, ogrenciler.final_notu
FROM ogrenciler
INNER JOIN dersler ON ogrenciler.ders_id = dersler.id;