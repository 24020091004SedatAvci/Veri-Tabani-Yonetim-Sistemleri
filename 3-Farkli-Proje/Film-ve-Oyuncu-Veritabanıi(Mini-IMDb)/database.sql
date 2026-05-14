CREATE DATABASE IF NOT EXISTS mini_imdb
CHARACTER SET utf8mb4
COLLATE utf8mb4_turkish_ci;

USE mini_imdb;

CREATE TABLE IF NOT EXISTS turler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tur_adi VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE IF NOT EXISTS yonetmenler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ad_soyad VARCHAR(150) NOT NULL UNIQUE,
    deneyim_yili INT,
    biyografi TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE IF NOT EXISTS oyuncular (
    id INT AUTO_INCREMENT PRIMARY KEY,
    oyuncu_adi VARCHAR(150) NOT NULL UNIQUE,
    dogum_tarihi DATE,
    biyografi TEXT,
    foto_url TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE IF NOT EXISTS filmler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_adi VARCHAR(150) NOT NULL UNIQUE,
    yayin_yili INT NOT NULL,
    tur_id INT NOT NULL,
    yonetmen_id INT NOT NULL,
    ozet TEXT,
    poster_url TEXT,
    sure_dk INT,
    puan DECIMAL(3,1),

    CONSTRAINT fk_film_tur
        FOREIGN KEY (tur_id)
        REFERENCES turler(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_film_yonetmen
        FOREIGN KEY (yonetmen_id)
        REFERENCES yonetmenler(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE IF NOT EXISTS film_oyunculari (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    oyuncu_id INT NOT NULL,
    rol_adi VARCHAR(150),

    CONSTRAINT fk_casting_film
        FOREIGN KEY (film_id)
        REFERENCES filmler(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_casting_oyuncu
        FOREIGN KEY (oyuncu_id)
        REFERENCES oyuncular(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT unique_film_oyuncu
        UNIQUE (film_id, oyuncu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;