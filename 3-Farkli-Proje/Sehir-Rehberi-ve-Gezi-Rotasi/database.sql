CREATE TABLE IF NOT EXISTS sehirler (
    id SERIAL PRIMARY KEY,
    sehir_adi VARCHAR(100) NOT NULL UNIQUE,
    bolge VARCHAR(100) NOT NULL,
    nufus INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS mekanlar (
    id SERIAL PRIMARY KEY,
    sehir_id INT NOT NULL,
    mekan_adi VARCHAR(150) NOT NULL UNIQUE,
    aciklama TEXT,
    tur VARCHAR(100) NOT NULL,
    resim_url TEXT,

    CONSTRAINT fk_mekan_sehir
        FOREIGN KEY (sehir_id)
        REFERENCES sehirler(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS etkinlikler (
    id SERIAL PRIMARY KEY,
    mekan_id INT NOT NULL,
    etkinlik_adi VARCHAR(150) NOT NULL,
    tarih DATE NOT NULL,
    ucret VARCHAR(100),

    CONSTRAINT fk_etkinlik_mekan
        FOREIGN KEY (mekan_id)
        REFERENCES mekanlar(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rehberler (
    id SERIAL PRIMARY KEY,
    rehber_adi VARCHAR(100) NOT NULL UNIQUE,
    uzmanlik_alani VARCHAR(150),
    iletisim VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS sehir_rehber_eslesme (
    id SERIAL PRIMARY KEY,
    sehir_id INT NOT NULL,
    rehber_id INT NOT NULL,

    CONSTRAINT fk_eslesme_sehir
        FOREIGN KEY (sehir_id)
        REFERENCES sehirler(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_eslesme_rehber
        FOREIGN KEY (rehber_id)
        REFERENCES rehberler(id)
        ON DELETE CASCADE,

    CONSTRAINT unique_sehir_rehber
        UNIQUE (sehir_id, rehber_id)
);