USE yemek_tarifi;

INSERT INTO kategoriler (kategori_adi) VALUES
('Çorba'),
('Ana Yemek'),
('Tatlı'),
('Salata'),
('Kahvaltılık'),
('Hamur İşi');

INSERT INTO malzemeler (malzeme_adi) VALUES
('Tuz'),
('Karabiber'),
('Pul Biber'),
('Kekik'),
('Nane'),
('Kimyon'),
('Sarımsak'),
('Soğan'),
('Domates'),
('Biber'),
('Patates'),
('Havuç'),
('Tavuk'),
('Kıyma'),
('Et'),
('Balık'),
('Mercimek'),
('Pirinç'),
('Bulgur'),
('Makarna'),
('Un'),
('Şeker'),
('Süt'),
('Yumurta'),
('Yoğurt'),
('Kaşar Peyniri'),
('Beyaz Peynir'),
('Tereyağı'),
('Sıvı Yağ'),
('Zeytinyağı'),
('Salça'),
('Su'),
('Limon'),
('Maydanoz'),
('Dereotu'),
('Marul'),
('Salatalık'),
('Lahana'),
('Mısır'),
('Bezelye'),
('Nohut'),
('Fasulye'),
('Kabak'),
('Patlıcan'),
('Mantar'),
('Krema'),
('Kabartma Tozu'),
('Vanilya'),
('Kakao'),
('Çikolata'),
('Bal'),
('Ceviz'),
('Fındık'),
('Badem'),
('Tarçın');

INSERT INTO tarifler 
(kategori_id, tarif_adi, aciklama, hazirlama_suresi, fotograf_url)
VALUES
(1, 'Mercimek Çorbası',
'1- Soğan, havuç ve patatesi doğrayıp kavurun.
2- Mercimeği ekleyip su ilave edin.
3- Sebzeler yumuşayana kadar pişirin.
4- Blenderdan geçirip baharatları ekleyin.
5- Sıcak servis edin.',
35,
'https://images.unsplash.com/photo-1547592166-23ac45744acd'),

(2, 'Tavuk Sote',
'1- Tavukları küçük parçalar halinde doğrayın.
2- Soğan ve biberleri tavada kavurun.
3- Tavukları ekleyip pişirin.
4- Domates ve baharatları ekleyin.
5- Sıcak servis edin.',
45,
'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d'),

(3, 'Sütlaç',
'1- Pirinci yıkayıp su ile haşlayın.
2- Sütü ekleyip karıştırarak pişirin.
3- Şekeri ekleyin.
4- Vanilyayı ekleyip kaselere paylaştırın.
5- Soğuduktan sonra servis edin.',
45,
'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e'),

(4, 'Çoban Salata',
'1- Domates, salatalık, biber ve soğanı doğrayın.
2- Maydanozu ince ince kıyın.
3- Tüm malzemeleri salata kabına alın.
4- Zeytinyağı, limon ve tuz ekleyin.
5- Karıştırıp servis edin.',
15,
'https://images.unsplash.com/photo-1512621776951-a57141f2eefd');