-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3307
-- Üretim Zamanı: 05 Mar 2026, 20:56:55
-- Sunucu sürümü: 12.2.2-MariaDB
-- PHP Sürümü: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `okul`
--
CREATE DATABASE IF NOT EXISTS `okul` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
USE `okul`;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dersler`
--

DROP TABLE IF EXISTS `dersler`;
CREATE TABLE IF NOT EXISTS `dersler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ders_adi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `dersler`
--

INSERT INTO `dersler` (`id`, `ders_adi`) VALUES
(1, 'Nesne Yönelimli Programlama'),
(2, 'Veri Yapıları'),
(3, 'Ayrık Matematik');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenciler`
--

DROP TABLE IF EXISTS `ogrenciler`;
CREATE TABLE IF NOT EXISTS `ogrenciler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_soyad` varchar(50) DEFAULT NULL,
  `sehir` varchar(50) DEFAULT NULL,
  `vize_notu` int(11) DEFAULT NULL,
  `final_notu` int(11) DEFAULT NULL,
  `ders_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `ogrenciler`
--

INSERT INTO `ogrenciler` (`id`, `ad_soyad`, `sehir`, `vize_notu`, `final_notu`, `ders_id`) VALUES
(1, 'Sedat Avcı', 'Mersin', 75, 100, 1),
(2, 'Muhammed Yusuf Nahırcı', 'Hatay', 90, 95, 1),
(4, 'Ali Fatih Arslan', 'Çorum', NULL, NULL, 3),
(5, 'Hüseyin Gildir', 'Adana', 85, 90, 2),
(6, 'Elif Şahin', 'İstanbul', 60, 70, 1),
(7, 'Burak Can', 'Antalya', 80, 88, 1);
--
-- Veritabanı: `okul_db`
--
CREATE DATABASE IF NOT EXISTS `okul_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci;
USE `okul_db`;
--
-- Veritabanı: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
