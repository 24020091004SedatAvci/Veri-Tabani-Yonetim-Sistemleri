CREATE DATABASE IF NOT EXISTS yemek_tarifi;

USE yemek_tarifi;

CREATE TABLE IF NOT EXISTS kategoriler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kategori_adi VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tarifler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kategori_id INT NOT NULL,
    tarif_adi VARCHAR(150) NOT NULL,
    aciklama TEXT,
    hazirlama_suresi INT,
    fotograf_url VARCHAR(500),
    olusturma_tarihi DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kategori_id) REFERENCES kategoriler(id)
);

CREATE TABLE IF NOT EXISTS malzemeler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    malzeme_adi VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tarif_malzemeleri (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tarif_id INT NOT NULL,
    malzeme_id INT NOT NULL,
    miktar VARCHAR(100),
    FOREIGN KEY (tarif_id) REFERENCES tarifler(id) ON DELETE CASCADE,
    FOREIGN KEY (malzeme_id) REFERENCES malzemeler(id)
);