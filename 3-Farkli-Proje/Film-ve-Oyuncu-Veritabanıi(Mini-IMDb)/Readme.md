# Film ve Oyuncu Veritabanı - Mini IMDb

Bu proje, PHP ve MySQL kullanılarak geliştirilmiş basit bir film ve oyuncu veritabanı uygulamasıdır.  
Uygulamada filmler, oyuncular, yönetmenler, türler ve film-oyuncu ilişkileri yönetilebilmektedir.

Proje, mini IMDb mantığıyla hazırlanmıştır. Kullanıcılar filmleri listeleyebilir, film detaylarını görüntüleyebilir, oyuncu profillerine ulaşabilir, kategoriye göre film filtreleyebilir ve film yönetimi ekranından film ekleme, düzenleme ve silme işlemleri yapabilir.

---

## Projenin Amacı

Bu projenin amacı, ilişkisel veri tabanı yapısını kullanarak film, oyuncu, yönetmen ve tür bilgilerinin web arayüzü üzerinden listelenmesini ve yönetilmesini sağlamaktır.

Projede özellikle çoktan çoğa ilişki mantığı kullanılmıştır.  
Bir filmde birden fazla oyuncu bulunabilir. Aynı oyuncu da birden fazla filmde oynayabilir. Bu ilişki `film_oyunculari` tablosu ile kurulmuştur.

---

## Kullanılan Teknolojiler

- PHP
- MySQL
- PDO
- HTML
- CSS
- XAMPP / Apache Server
- phpMyAdmin

---

## Uygulama Özellikleri

- Filmleri posterleriyle listeleme
- Film detaylarını görüntüleme
- Film türüne göre filtreleme
- Oyuncu profili görüntüleme
- Oyuncunun oynadığı filmleri listeleme
- Film ekleme
- Film düzenleme
- Film silme
- Film eklerken oyuncu ve rol bilgisi atama
- Film düzenlerken oyuncu kadrosunu güncelleme
- Yönetmen, tür ve oyuncu ilişkilerini veri tabanı üzerinden yönetme

---

# Veri Tabanı Tasarımı

Projede MySQL veri tabanı kullanılmıştır. Veri tabanı toplam 5 tablodan oluşmaktadır.

## Veri Tabanı Adı

```sql
mini_imdb
```

## Tablolar

1. `turler`
2. `yonetmenler`
3. `oyuncular`
4. `filmler`
5. `film_oyunculari`

---

## 1. `turler` Tablosu

Bu tablo film türlerini tutar.

Örnek türler:

- Aksiyon
- Dram
- Bilim Kurgu
- Komedi
- Macera
- Gerilim
- Fantastik
- Suç
- Romantik

| Sütun Adı | Veri Tipi | Açıklama |
|---|---|---|
| id | INT | Türün benzersiz ID değeridir. Birincil anahtar olarak kullanılır. |
| tur_adi | VARCHAR(100) | Film türünün adını tutar. |

### İlişki

`turler.id` alanı, `filmler.tur_id` alanı ile ilişkilidir.

Bir türde birden fazla film olabilir.  
Ancak bir film yalnızca bir türe bağlıdır.

### Örnek Kayıtlar

| id | tur_adi |
|---|---|
| 1 | Aksiyon |
| 2 | Dram |
| 3 | Bilim Kurgu |
| 4 | Komedi |
| 5 | Macera |

---

## 2. `yonetmenler` Tablosu

Bu tablo yönetmen bilgilerini tutar.

| Sütun Adı | Veri Tipi | Açıklama |
|---|---|---|
| id | INT | Yönetmenin benzersiz ID değeridir. Birincil anahtar olarak kullanılır. |
| ad_soyad | VARCHAR(150) | Yönetmenin ad ve soyad bilgisini tutar. |
| deneyim_yili | INT | Yönetmenin kaç yıllık deneyime sahip olduğunu belirtir. |
| biyografi | TEXT | Yönetmen hakkında kısa açıklama bilgisini tutar. |

### İlişki

`yonetmenler.id` alanı, `filmler.yonetmen_id` alanı ile ilişkilidir.

Bir yönetmenin birden fazla filmi olabilir.  
Ancak bir film yalnızca bir yönetmene bağlıdır.

### Örnek Kayıtlar

| id | ad_soyad | deneyim_yili |
|---|---|---|
| 1 | Christopher Nolan | 25 |
| 2 | Frank Darabont | 30 |
| 3 | Peter Jackson | 35 |
| 4 | James Cameron | 40 |
| 5 | David Fincher | 30 |

---

## 3. `oyuncular` Tablosu

Bu tablo oyuncu bilgilerini tutar.

| Sütun Adı | Veri Tipi | Açıklama |
|---|---|---|
| id | INT | Oyuncunun benzersiz ID değeridir. Birincil anahtar olarak kullanılır. |
| oyuncu_adi | VARCHAR(150) | Oyuncunun adını tutar. |
| dogum_tarihi | DATE | Oyuncunun doğum tarihini tutar. |
| biyografi | TEXT | Oyuncu hakkında kısa açıklama bilgisini tutar. |
| foto_url | TEXT | Oyuncunun fotoğraf yolunu veya görsel bağlantısını tutar. |

### İlişki

`oyuncular.id` alanı, `film_oyunculari.oyuncu_id` alanı ile ilişkilidir.

Bir oyuncu birden fazla filmde oynayabilir.  
Bu ilişki doğrudan `filmler` tablosuyla değil, `film_oyunculari` ilişki tablosu üzerinden kurulur.

### Örnek Kayıtlar

| id | oyuncu_adi | dogum_tarihi |
|---|---|---|
| 1 | Leonardo DiCaprio | 1974-11-11 |
| 2 | Morgan Freeman | 1937-06-01 |
| 3 | Keanu Reeves | 1964-09-02 |
| 4 | Tom Hanks | 1956-07-09 |
| 5 | Brad Pitt | 1963-12-18 |

---

## 4. `filmler` Tablosu

Bu tablo film bilgilerini tutar.

| Sütun Adı | Veri Tipi | Açıklama |
|---|---|---|
| id | INT | Filmin benzersiz ID değeridir. Birincil anahtar olarak kullanılır. |
| film_adi | VARCHAR(150) | Filmin adını tutar. |
| yayin_yili | INT | Filmin yayın yılını tutar. |
| tur_id | INT | Filmin ait olduğu türü belirtir. `turler` tablosuna bağlıdır. |
| yonetmen_id | INT | Filmin yönetmenini belirtir. `yonetmenler` tablosuna bağlıdır. |
| ozet | TEXT | Filmin kısa özet bilgisini tutar. |
| poster_url | TEXT | Film posterinin dosya yolunu veya görsel bağlantısını tutar. |
| sure_dk | INT | Filmin süresini dakika cinsinden tutar. |
| puan | DECIMAL(3,1) | Filmin IMDb benzeri puanını tutar. |

### İlişki

`filmler.tur_id` alanı, `turler.id` alanına bağlıdır.  
`filmler.yonetmen_id` alanı, `yonetmenler.id` alanına bağlıdır.  
`filmler.id` alanı, `film_oyunculari.film_id` alanı ile ilişkilidir.

Bir film bir türe ve bir yönetmene bağlıdır.  
Bir filmde birden fazla oyuncu bulunabilir.

### Örnek Kayıtlar

| id | film_adi | yayin_yili | tur_id | yonetmen_id | puan |
|---|---|---|---|---|---|
| 1 | Inception | 2010 | 3 | 1 | 8.8 |
| 2 | The Shawshank Redemption | 1994 | 2 | 2 | 9.3 |
| 3 | The Matrix | 1999 | 3 | 5 | 8.7 |
| 4 | Fight Club | 1999 | 6 | 6 | 8.8 |
| 5 | Joker | 2019 | 2 | 7 | 8.4 |

---

## 5. `film_oyunculari` Tablosu

Bu tablo film ve oyuncu arasındaki ilişkiyi tutar.

Bir filmde birden fazla oyuncu olabilir.  
Bir oyuncu da birden fazla filmde oynayabilir.

Bu yüzden `filmler` ve `oyuncular` tabloları arasında çoktan çoğa ilişki vardır.  
Bu ilişki `film_oyunculari` tablosu ile sağlanır.

| Sütun Adı | Veri Tipi | Açıklama |
|---|---|---|
| id | INT | İlişki kaydının benzersiz ID değeridir. Birincil anahtar olarak kullanılır. |
| film_id | INT | Oyuncunun oynadığı filmi belirtir. `filmler` tablosuna bağlıdır. |
| oyuncu_id | INT | Filmde oynayan oyuncuyu belirtir. `oyuncular` tablosuna bağlıdır. |
| rol_adi | VARCHAR(150) | Oyuncunun filmdeki rol adını tutar. |

### İlişki

`film_oyunculari.film_id` alanı, `filmler.id` alanına bağlıdır.  
`film_oyunculari.oyuncu_id` alanı, `oyuncular.id` alanına bağlıdır.

Bu tablo sayesinde aynı filme birden fazla oyuncu eklenebilir.  
Aynı oyuncu farklı filmlerde farklı rollerle yer alabilir.

### Örnek Kayıtlar

| id | film_id | oyuncu_id | rol_adi |
|---|---|---|---|
| 1 | 1 | 1 | Dom Cobb |
| 2 | 1 | 2 | Arthur |
| 3 | 3 | 3 | Neo |
| 4 | 4 | 5 | Tyler Durden |
| 5 | 5 | 6 | Arthur Fleck |

---

# Tablolar Arası İlişkiler

| Ana Tablo | Bağlı Tablo | İlişki Türü | Açıklama |
|---|---|---|---|
| turler | filmler | 1 - N | Bir türde birden fazla film olabilir. |
| yonetmenler | filmler | 1 - N | Bir yönetmenin birden fazla filmi olabilir. |
| filmler | film_oyunculari | 1 - N | Bir film birden fazla oyuncu ilişkisine sahip olabilir. |
| oyuncular | film_oyunculari | 1 - N | Bir oyuncu birden fazla film ilişkisine sahip olabilir. |
| filmler | oyuncular | N - N | Çoktan çoğa ilişki `film_oyunculari` tablosu ile kurulur. |

---

# İlişki Şeması

```txt
turler 1 -------- N filmler

yonetmenler 1 --- N filmler

filmler 1 ------- N film_oyunculari N ------- 1 oyuncular
```

Açıklama:

- Bir film bir türe aittir.
- Bir türde birden fazla film bulunabilir.
- Bir film bir yönetmene aittir.
- Bir yönetmenin birden fazla filmi olabilir.
- Bir filmde birden fazla oyuncu olabilir.
- Bir oyuncu birden fazla filmde oynayabilir.
- Oyuncunun filmdeki rol adı `film_oyunculari` tablosunda tutulur.

---

# Örnek Veri Akışı

1. Kullanıcı ana sayfada filmleri görüntüler.
2. Kullanıcı bir filme tıklayınca film detay sayfası açılır.
3. Film detay sayfasında filmin türü, yönetmeni ve oyuncu kadrosu görüntülenir.
4. Kullanıcı oyuncu adına tıklayınca oyuncu profili açılır.
5. Oyuncu profilinde oyuncunun oynadığı tüm filmler listelenir.
6. Kullanıcı kategori butonuna tıklayarak aynı türe ait filmleri görüntüleyebilir.
7. Film yönetimi ekranından yeni film eklenebilir.
8. Film eklerken oyuncular ve rol adları da seçilebilir.
9. Film düzenleme ekranında film bilgileri ve oyuncu kadrosu güncellenebilir.
10. Film silme işlemi ile film ve filme ait oyuncu ilişkileri kaldırılabilir.

---

# Proje Sayfaları

| Sayfa | Açıklama |
|---|---|
| `index.php` | Ana sayfa. Film vitrinini ve öne çıkan oyuncuları listeler. |
| `film-detay.php` | Seçilen filmin detaylarını, yönetmenini ve oyuncu kadrosunu gösterir. |
| `oyuncu-profil.php` | Seçilen oyuncunun bilgilerini ve oynadığı filmleri gösterir. |
| `kategori.php` | Seçilen türe ait filmleri listeler. |
| `film-yonetim.php` | Filmleri tablo halinde listeler. Düzenleme ve silme işlemlerine yönlendirir. |
| `film-ekle.php` | Yeni film ekleme ekranıdır. Oyuncu ve rol bilgisi de eklenebilir. |
| `film-duzenle.php` | Mevcut film bilgilerini ve oyuncu kadrosunu düzenler. |
| `film-sil.php` | Seçilen filmi ve filme ait oyuncu ilişkilerini siler. |
| `baglanti.php` | MySQL veri tabanı bağlantısını sağlar. |
| `style.css` | Uygulamanın arayüz tasarımını içerir. |

---

# Kullanılan Temel SQL Sorguları

## Film Detay Bilgisi

Film detay sayfasında film, tür ve yönetmen bilgileri birlikte getirilir.

```sql
SELECT 
    filmler.*,
    turler.tur_adi,
    yonetmenler.ad_soyad AS yonetmen_adi,
    yonetmenler.deneyim_yili
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
INNER JOIN yonetmenler ON filmler.yonetmen_id = yonetmenler.id
WHERE filmler.id = ?;
```

---

## Filmdeki Oyuncular

Bir filme ait oyuncular ve rol adları ilişki tablosu üzerinden getirilir.

```sql
SELECT 
    oyuncular.id,
    oyuncular.oyuncu_adi,
    oyuncular.foto_url,
    film_oyunculari.rol_adi
FROM film_oyunculari
INNER JOIN oyuncular ON film_oyunculari.oyuncu_id = oyuncular.id
WHERE film_oyunculari.film_id = ?;
```

---

## Oyuncunun Oynadığı Filmler

Oyuncu profilinde, oyuncunun yer aldığı tüm filmler listelenir.

```sql
SELECT 
    filmler.id,
    filmler.film_adi,
    filmler.yayin_yili,
    filmler.poster_url,
    film_oyunculari.rol_adi
FROM film_oyunculari
INNER JOIN filmler ON film_oyunculari.film_id = filmler.id
WHERE film_oyunculari.oyuncu_id = ?;
```

---

## Kategoriye Göre Film Listeleme

Kategori sayfasında seçilen türe ait filmler listelenir.

```sql
SELECT 
    filmler.id,
    filmler.film_adi,
    filmler.yayin_yili,
    filmler.poster_url,
    filmler.puan,
    turler.tur_adi
FROM filmler
INNER JOIN turler ON filmler.tur_id = turler.id
WHERE turler.id = ?;
```

---

# CRUD İşlemleri

Projede CRUD işlemleri film kayıtları üzerinde uygulanmıştır.

| İşlem | Sayfa | Açıklama |
|---|---|---|
| Create | `film-ekle.php` | Yeni film eklenir. Film eklenirken oyuncu ve rol bilgileri de eklenebilir. |
| Read | `index.php`, `film-detay.php`, `oyuncu-profil.php`, `kategori.php` | Filmler, film detayları, oyuncu profilleri ve kategoriler görüntülenir. |
| Update | `film-duzenle.php` | Mevcut film bilgileri ve oyuncu kadrosu güncellenir. |
| Delete | `film-sil.php` | Film kaydı ve filme ait oyuncu ilişkileri silinir. |

---

# Örnek Filmler

| Film | Tür | Yönetmen |
|---|---|---|
| Inception | Bilim Kurgu | Christopher Nolan |
| The Matrix | Bilim Kurgu | Lana Wachowski |
| Fight Club | Gerilim | David Fincher |
| Pulp Fiction | Suç | Quentin Tarantino |
| Joker | Dram | Todd Phillips |
| Forrest Gump | Dram | Robert Zemeckis |

---

# Örnek Oyuncular

| Oyuncu | Film | Rol |
|---|---|---|
| Leonardo DiCaprio | Inception | Dom Cobb |
| Joseph Gordon-Levitt | Inception | Arthur |
| Keanu Reeves | The Matrix | Neo |
| Carrie-Anne Moss | The Matrix | Trinity |
| Brad Pitt | Fight Club | Tyler Durden |
| Joaquin Phoenix | Joker | Arthur Fleck |
| Tom Hanks | Forrest Gump | Forrest Gump |

---

# Proje Dosya Yapısı

```txt
mini-imdb/
├── baglanti.php
├── index.php
├── film-detay.php
├── oyuncu-profil.php
├── kategori.php
├── film-yonetim.php
├── film-ekle.php
├── film-duzenle.php
├── film-sil.php
├── style.css
├── img/
│   ├── filmler/
│   └── oyuncular/
└── screenshots/
    ├── 01-anasayfa.png
    ├── 02-film-detay.png
    ├── 03-oyuncu-profili.png
    ├── 04-kategori-sayfasi.png
    ├── 05-film-yonetimi.png
    ├── 06-film-ekle.png
    ├── 07-film-duzenle.png
    └── 08-veritabani-semasi.png
```

---

## Veri Tabanı Kurulumu

1. MySQL veya phpMyAdmin üzerinden yeni bir veri tabanı oluşturun.

```sql
CREATE DATABASE mini_imdb CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
```

2. `database.sql` dosyasını çalıştırarak tabloları oluşturun.

3. `seed.sql` dosyasını çalıştırarak örnek verileri ekleyin.

4. `baglanti.php` dosyasındaki veri tabanı bilgilerini kendi bilgisayarınıza göre düzenleyin.

```php
$host = "localhost";
$dbname = "mini_imdb";
$username = "root";
$password = "";
```

5. Projeyi XAMPP `www` klasörüne yerleştirin.

```txt
C:/xampp/www/mini-imdb
```

6. Tarayıcı üzerinden projeyi çalıştırın.

```txt
http://localhost/mini-imdb/index.php
```

---


# Geliştirici

**Sedat Avcı**

Bu proje, Veri Tabanı Yönetim Sistemleri dersi kapsamında ödev amacıyla hazırlanmıştır.

---

# Ekran Görüntüleri

## Ana Sayfa

![Ana Sayfa](<img width="1906" height="1064" alt="ana-sayfa" src="https://github.com/user-attachments/assets/0f118e1a-f33e-45f5-b5ce-050f9ca64941" />)


## Film Detay Sayfası

![Film Detay](screenshots/02-film-detay.png)

## Oyuncu Profili Sayfası

![Oyuncu Profili](screenshots/03-oyuncu-profili.png)

## Kategori Sayfası

![Kategori Sayfası](screenshots/04-kategori-sayfasi.png)

## Film Yönetimi Sayfası

![Film Yönetimi](screenshots/05-film-yonetimi.png)

## Film Ekleme Sayfası

![Film Ekle](screenshots/06-film-ekle.png)

## Film Düzenleme Sayfası

![Film Düzenle](screenshots/07-film-duzenle.png)

## Veri Tabanı Şeması

![Veri Tabanı Şeması](screenshots/08-veritabani-semasi.png)

---

# Sonuç

Bu proje ile PHP ve MySQL kullanılarak ilişkisel veri tabanına bağlı çalışan bir Mini IMDb uygulaması geliştirilmiştir.

Projede film, oyuncu, yönetmen ve tür bilgileri ayrı tablolarda tutulmuştur.  
Film ve oyuncular arasındaki çoktan çoğa ilişki `film_oyunculari` tablosu ile sağlanmıştır.

Uygulama içerisinde film listeleme, film detay görüntüleme, oyuncu profili, kategori filtreleme, film ekleme, film düzenleme ve film silme işlemleri yapılabilmektedir.
