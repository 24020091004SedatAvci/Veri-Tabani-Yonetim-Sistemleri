USE mini_imdb;

-- TÜRLER
INSERT INTO turler (tur_adi) VALUES
('Aksiyon'),
('Dram'),
('Bilim Kurgu'),
('Komedi'),
('Macera'),
('Fantastik'),
('Gerilim'),
('Romantik'),
('Suç')
ON DUPLICATE KEY UPDATE tur_adi = VALUES(tur_adi);

-- YÖNETMENLER
INSERT INTO yonetmenler (ad_soyad, deneyim_yili, biyografi) VALUES
('Christopher Nolan', 25, 'Karmaşık hikaye yapıları ve güçlü sinematografisiyle tanınan yönetmen.'),
('Frank Darabont', 30, 'Dram türündeki başarılı filmleriyle bilinen yönetmen.'),
('Peter Jackson', 35, 'Fantastik ve macera filmleriyle tanınan yönetmen.'),
('James Cameron', 40, 'Bilim kurgu ve yüksek bütçeli yapımlarıyla tanınır.'),
('David Fincher', 30, 'Gerilim ve psikolojik dram türündeki filmleriyle tanınan yönetmen.'),
('Quentin Tarantino', 32, 'Kendine özgü diyalogları ve sinema diliyle tanınan yönetmen.'),
('Todd Phillips', 20, 'Dram ve kara mizah türündeki yapımlarıyla bilinen yönetmen.'),
('Robert Zemeckis', 35, 'Dram ve macera türündeki başarılı filmleriyle tanınan yönetmen.'),
('Lana Wachowski', 28, 'Bilim kurgu türündeki yenilikçi filmleriyle tanınan yönetmen.')
ON DUPLICATE KEY UPDATE 
    deneyim_yili = VALUES(deneyim_yili),
    biyografi = VALUES(biyografi);

-- OYUNCULAR
INSERT INTO oyuncular (oyuncu_adi, dogum_tarihi, biyografi, foto_url) VALUES
('Leonardo DiCaprio', '1974-11-11', 'Amerikalı oyuncu, birçok başarılı filmde başrol oynamıştır.', 'img/oyuncular/leonardo-dicaprio.jpg'),
('Joseph Gordon-Levitt', '1981-02-17', 'Amerikalı oyuncu ve film yapımcısıdır.', 'img/oyuncular/joseph-gordon-levitt.jpg'),
('Morgan Freeman', '1937-06-01', 'Derin sesi ve güçlü oyunculuğuyla tanınan Amerikalı oyuncu.', 'img/oyuncular/morgan-freeman.jpg'),
('Tim Robbins', '1958-10-16', 'Amerikalı oyuncu, senarist ve yönetmendir.', 'img/oyuncular/tim-robbins.jpg'),
('Elijah Wood', '1981-01-28', 'Yüzüklerin Efendisi serisindeki Frodo rolüyle tanınır.', 'img/oyuncular/elijah-wood.jpg'),
('Ian McKellen', '1939-05-25', 'İngiliz tiyatro ve sinema oyuncusudur.', 'img/oyuncular/ian-mckellen.jpg'),
('Sam Worthington', '1976-08-02', 'Avatar filmindeki Jake Sully rolüyle bilinir.', 'img/oyuncular/sam-worthington.jpg'),
('Zoe Saldana', '1978-06-19', 'Bilim kurgu filmleriyle tanınan Amerikalı oyuncudur.', 'img/oyuncular/zoe-saldana.jpg'),
('Christian Bale', '1974-01-30', 'Farklı rollere fiziksel olarak hazırlanmasıyla tanınan oyuncu.', 'img/oyuncular/christian-bale.jpg'),
('Heath Ledger', '1979-04-04', 'Avustralyalı oyuncudur.', 'img/oyuncular/heath-ledger.jpg'),
('Brad Pitt', '1963-12-18', 'Amerikalı oyuncu ve yapımcıdır.', 'img/oyuncular/brad-pitt.jpg'),
('Edward Norton', '1969-08-18', 'Amerikalı oyuncu ve yönetmendir.', 'img/oyuncular/edward-norton.jpg'),
('Joaquin Phoenix', '1974-10-28', 'Güçlü dramatik rolleriyle tanınan Amerikalı oyuncudur.', 'img/oyuncular/joaquin-phoenix.jpg'),
('John Travolta', '1954-02-18', 'Amerikalı oyuncu ve dansçıdır.', 'img/oyuncular/john-travolta.jpg'),
('Uma Thurman', '1970-04-29', 'Amerikalı oyuncu ve modeldir.', 'img/oyuncular/uma-thurman.jpg'),
('Tom Hanks', '1956-07-09', 'Amerikalı oyuncu ve yapımcıdır.', 'img/oyuncular/tom-hanks.jpg'),
('Keanu Reeves', '1964-09-02', 'Aksiyon ve bilim kurgu filmleriyle tanınan Kanadalı oyuncudur.', 'img/oyuncular/keanu-reeves.jpg'),
('Carrie-Anne Moss', '1967-08-21', 'Matrix serisindeki Trinity rolüyle tanınan oyuncudur.', 'img/oyuncular/carrie-anne-moss.jpg')
ON DUPLICATE KEY UPDATE 
    dogum_tarihi = VALUES(dogum_tarihi),
    biyografi = VALUES(biyografi),
    foto_url = VALUES(foto_url);

-- FİLMLER
INSERT INTO filmler 
(film_adi, yayin_yili, tur_id, yonetmen_id, ozet, poster_url, sure_dk, puan)
VALUES
(
    'Inception',
    2010,
    (SELECT id FROM turler WHERE tur_adi = 'Bilim Kurgu'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Christopher Nolan'),
    'Rüya içinde rüya konseptiyle ilerleyen bilim kurgu filmidir.',
    'img/filmler/inception.jpg',
    148,
    8.8
),
(
    'The Shawshank Redemption',
    1994,
    (SELECT id FROM turler WHERE tur_adi = 'Dram'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Frank Darabont'),
    'Haksız yere hapse giren bir adamın umut ve dostluk hikayesidir.',
    'img/filmler/shawshank.jpg',
    142,
    9.3
),
(
    'The Lord of the Rings',
    2001,
    (SELECT id FROM turler WHERE tur_adi = 'Fantastik'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Peter Jackson'),
    'Bir yüzüğü yok etmek için verilen büyük mücadeleyi anlatır.',
    'img/filmler/lotr.jpg',
    178,
    8.9
),
(
    'Avatar',
    2009,
    (SELECT id FROM turler WHERE tur_adi = 'Bilim Kurgu'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'James Cameron'),
    'Pandora gezegeninde geçen görsel açıdan etkileyici bir bilim kurgu filmidir.',
    'img/filmler/avatar.jpg',
    162,
    7.9
),
(
    'The Dark Knight',
    2008,
    (SELECT id FROM turler WHERE tur_adi = 'Aksiyon'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Christopher Nolan'),
    'Batman ve Joker arasındaki psikolojik savaşı konu alır.',
    'img/filmler/dark-knight.jpg',
    152,
    9.0
),
(
    'Fight Club',
    1999,
    (SELECT id FROM turler WHERE tur_adi = 'Gerilim'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'David Fincher'),
    'Modern hayatın baskısından bunalan bir adamın gizemli bir karakterle tanışmasını konu alır.',
    'img/filmler/fight-club.jpg',
    139,
    8.8
),
(
    'Pulp Fiction',
    1994,
    (SELECT id FROM turler WHERE tur_adi = 'Suç'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Quentin Tarantino'),
    'Birbirine bağlanan suç hikayelerini kara mizah ve farklı anlatım tarzıyla sunar.',
    'img/filmler/pulp-fiction.jpg',
    154,
    8.9
),
(
    'Joker',
    2019,
    (SELECT id FROM turler WHERE tur_adi = 'Dram'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Todd Phillips'),
    'Toplumdan dışlanan Arthur Fleck karakterinin Joker kimliğine dönüşümünü anlatır.',
    'img/filmler/joker.jpg',
    122,
    8.4
),
(
    'Forrest Gump',
    1994,
    (SELECT id FROM turler WHERE tur_adi = 'Dram'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Robert Zemeckis'),
    'Saf ve iyi niyetli Forrest Gump karakterinin hayat yolculuğunu anlatır.',
    'img/filmler/forrest-gump.jpg',
    142,
    8.8
),
(
    'The Matrix',
    1999,
    (SELECT id FROM turler WHERE tur_adi = 'Bilim Kurgu'),
    (SELECT id FROM yonetmenler WHERE ad_soyad = 'Lana Wachowski'),
    'Gerçeklik algısını sorgulatan, yapay dünya ve özgürlük temasını işleyen bilim kurgu filmidir.',
    'img/filmler/matrix.jpg',
    136,
    8.7
)
ON DUPLICATE KEY UPDATE
    yayin_yili = VALUES(yayin_yili),
    tur_id = VALUES(tur_id),
    yonetmen_id = VALUES(yonetmen_id),
    ozet = VALUES(ozet),
    poster_url = VALUES(poster_url),
    sure_dk = VALUES(sure_dk),
    puan = VALUES(puan);

-- FİLM - OYUNCU İLİŞKİLERİ
INSERT INTO film_oyunculari (film_id, oyuncu_id, rol_adi) VALUES
(
    (SELECT id FROM filmler WHERE film_adi = 'Inception'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Leonardo DiCaprio'),
    'Dom Cobb'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Inception'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Joseph Gordon-Levitt'),
    'Arthur'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Shawshank Redemption'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Morgan Freeman'),
    'Ellis Boyd Redding'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Shawshank Redemption'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Tim Robbins'),
    'Andy Dufresne'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Lord of the Rings'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Elijah Wood'),
    'Frodo Baggins'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Lord of the Rings'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Ian McKellen'),
    'Gandalf'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Avatar'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Sam Worthington'),
    'Jake Sully'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Avatar'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Zoe Saldana'),
    'Neytiri'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Dark Knight'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Christian Bale'),
    'Bruce Wayne'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Dark Knight'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Heath Ledger'),
    'Joker'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Fight Club'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Brad Pitt'),
    'Tyler Durden'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Fight Club'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Edward Norton'),
    'Anlatıcı'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Pulp Fiction'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'John Travolta'),
    'Vincent Vega'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Pulp Fiction'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Uma Thurman'),
    'Mia Wallace'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Joker'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Joaquin Phoenix'),
    'Arthur Fleck'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'Forrest Gump'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Tom Hanks'),
    'Forrest Gump'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Matrix'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Keanu Reeves'),
    'Neo'
),
(
    (SELECT id FROM filmler WHERE film_adi = 'The Matrix'),
    (SELECT id FROM oyuncular WHERE oyuncu_adi = 'Carrie-Anne Moss'),
    'Trinity'
)
ON DUPLICATE KEY UPDATE
    rol_adi = VALUES(rol_adi);