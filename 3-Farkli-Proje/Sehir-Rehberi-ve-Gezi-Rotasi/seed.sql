INSERT INTO sehirler (sehir_adi, bolge, nufus)
VALUES
('Erzurum', 'Doğu Anadolu', 736877),
('Mersin', 'Akdeniz', 1956428),
('Adana', 'Akdeniz', 2283609),
('İstanbul', 'Marmara', 15754053),
('Ankara', 'İç Anadolu', 5910320),
('İzmir', 'Ege', 4504185),
('Antalya', 'Akdeniz', 2777677)
ON CONFLICT (sehir_adi) DO NOTHING;


INSERT INTO mekanlar (sehir_id, mekan_adi, aciklama, tur, resim_url)
VALUES
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Erzurum'),
    'Çifte Minareli Medrese',
    'Çifte Minareli Medrese, Erzurum’un en önemli tarihi yapılarından biridir. Selçuklu mimarisinin izlerini taşıyan bu yapı, görkemli taş işçiliği ve çift minaresiyle dikkat çeker.',
    'Tarihi Yer',
    'https://www.kulturportali.gov.tr/contents/images/ERZURUM-%C3%87%C4%B0FTE%20M%C4%B0NAREL%C4%B0%20MEDRESE-G%C3%9CLCAN%20ACAR%20(5).jpg'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Mersin'),
    'Cennet Cehennem Mağarası',
    'Cennet Cehennem Mağaraları, doğal yapısı ve etkileyici manzarasıyla Mersin’in en bilinen turistik alanlarından biridir.',
    'Doğa',
    'https://www.essizmersin.com/files/emf-cennet-cehennem-1jpg_06-10-2021_14-51-35.jpg'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Adana'),
    'Merkez Park',
    'Merkez Park, geniş yeşil alanları ve Seyhan Nehri kıyısındaki konumuyla Adana’nın önemli gezi noktalarından biridir.',
    'Park',
    'https://www.adanabaska.com/thumb.php?src=files/gondol-marina-adana-merkez-parkjpg_31-05-2018_15-24-07.jpg&size=1094x715'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'İstanbul'),
    'Ayasofya Camii',
    'Ayasofya Camii, İstanbul’un en önemli tarihi yapılarından biridir. Bizans ve Osmanlı dönemlerinden izler taşıyan mimarisiyle kültürel açıdan büyük öneme sahiptir.',
    'Tarihi Yer',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtGqh2yGoyWSvgpFT3K87Tefmh1QezEBVPFw&s'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Ankara'),
    'Anıtkabir',
    'Anıtkabir, Türkiye Cumhuriyeti’nin kurucusu Mustafa Kemal Atatürk’ün anıt mezarıdır. Ankara’nın en önemli tarihi ve milli ziyaret noktalarından biridir.',
    'Tarihi Yer',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSabGXYR9GY2EUMf6Cv-pR6wMTpT5qFIM4g&s'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'İzmir'),
    'Efes Antik Kenti',
    'Efes Antik Kenti, İzmir’in Selçuk ilçesinde bulunan ve antik dönemin en önemli yerleşimlerinden biri olarak bilinen tarihi bir alandır.',
    'Tarihi Yer',
    'https://cocuklagezin.com/wp-content/uploads/2016/03/efes_antik_kenti_cover.jpg'
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Antalya'),
    'Düden Şelalesi',
    'Düden Şelalesi, Antalya’nın doğal güzelliklerinden biridir. Yeşil doğası, yürüyüş alanları ve etkileyici manzarasıyla ziyaretçilerin ilgisini çeker.',
    'Doğa',
    'https://europa.tips/wordpress/wp-content/uploads/Dueden-Selalesi-1024x577.webp'
)
ON CONFLICT (mekan_adi) DO NOTHING;


INSERT INTO etkinlikler (mekan_id, etkinlik_adi, tarih, ucret)
VALUES
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Çifte Minareli Medrese'),
    'Selçuklu Mimari Gezisi',
    '2026-06-10',
    'Ücretsiz'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Cennet Cehennem Mağarası'),
    'Mağara ve Doğa Yürüyüşü',
    '2026-06-15',
    '120 TL'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Merkez Park'),
    'Açık Hava Park Etkinliği',
    '2026-06-20',
    'Ücretsiz'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Ayasofya Camii'),
    'Tarihi İstanbul Rehberli Turu',
    '2026-06-25',
    '200 TL'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Anıtkabir'),
    'Cumhuriyet Tarihi Gezisi',
    '2026-06-29',
    'Ücretsiz'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Efes Antik Kenti'),
    'Antik Kent Kültür Turu',
    '2026-07-03',
    '180 TL'
),
(
    (SELECT id FROM mekanlar WHERE mekan_adi = 'Düden Şelalesi'),
    'Şelale Manzara ve Fotoğraf Gezisi',
    '2026-07-08',
    '100 TL'
);


INSERT INTO rehberler (rehber_adi, uzmanlik_alani, iletisim)
VALUES
('Mehmet Yıldırım', 'Tarih ve Selçuklu Mimarisi', '0501 111 25 25'),
('Ayşe Demir', 'Doğa Gezileri ve Mağara Turları', '0502 222 33 44'),
('Burak Kaya', 'Park ve Şehir Gezileri', '0503 333 44 55'),
('Zeynep Aydın', 'Osmanlı ve Bizans Tarihi', '0504 444 55 66'),
('Caner Özkan', 'Cumhuriyet Tarihi', '0505 555 66 77'),
('Elif Şahin', 'Antik Kentler ve Arkeoloji', '0506 666 77 88'),
('Murat Aksoy', 'Şelale ve Doğa Rotaları', '0507 777 88 99')
ON CONFLICT (rehber_adi) DO NOTHING;


INSERT INTO sehir_rehber_eslesme (sehir_id, rehber_id)
VALUES
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Erzurum'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Mehmet Yıldırım')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Mersin'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Ayşe Demir')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Adana'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Burak Kaya')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'İstanbul'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Zeynep Aydın')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Ankara'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Caner Özkan')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'İzmir'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Elif Şahin')
),
(
    (SELECT id FROM sehirler WHERE sehir_adi = 'Antalya'),
    (SELECT id FROM rehberler WHERE rehber_adi = 'Murat Aksoy')
)
ON CONFLICT (sehir_id, rehber_id) DO NOTHING;