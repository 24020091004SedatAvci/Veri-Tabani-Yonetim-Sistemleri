# 🌿 Günlük Ajandam (To-Do & Not Defteri Mobil Uygulaması)

**Kahramanmaraş İstiklal Üniversitesi** **Geliştirici:** Sedat Avcı  

**Günlük Ajandam**, React Native mimarisi kullanılarak Android platformu için geliştirilmiş, tam işlevsel (CRUD) bir yerel not defteri ve yapılacaklar listesi (To-Do) uygulamasıdır. Projenin temel amacı, yerel bir veritabanı yönetim sistemi (**SQLite**) entegrasyonunu sağlamak, verileri güvenli ve ilişkisel bir yapıda tutarak kullanıcı deneyimini (UI/UX) üst seviyede sunmaktır.

Uygulama, **Context API** tabanlı dinamik bir tema motoruna (Aydınlık / Karanlık Mod), modern animasyonlu açılır pencerelere (**Modal**) ve görev tamamlama durum takibine sahiptir. Tüm arayüz bileşenleri **UTF-8** standartlarında tam **Türkçe karakter desteği** sunmaktadır.

---

## ✨ Ana Özellikler

* **Çapraz Platform ve Yerel SQLite Entegrasyonu:** `react-native-sqlite-storage` kütüphanesi kullanılarak veriler cihazın yerel hafızasında saklanır.
* **Tam Veritabanı CRUD Döngüsü:**
  * **Ekleme (Create):** Kullanıcı notları anlık olarak SQL sorgusuyla veritabanına yazılır.
  * **Okuma (Read):** Kayıtlar `id DESC` (en yeni not en üstte) sıralanarak `FlatList` ile performanslı biçimde listelenir.
  * **Güncelleme (Update):** Seçilen not, sayfa değiştirilmeden modern bir Bottom-Sheet Modal içerisinde güncellenir.
  * **Silme (Delete):** İstenmeyen notlar veritabanından kalıcı olarak kaldırılır.
* **To-Do (Yapılacaklar) Mantığı:** Her nota bir `isCompleted` bayrağı eklenmiştir. Tamamlanan notların arayüzde üstü çizilir, opaklığı düşer ve yeşil tamamlama butonu gri bir "Geri Al" butonuna dönüşür.
* **Dinamik Tema Motoru (Dark / Light Mode):** Sağ üst köşede bulunan Güneş/Ay ikonlarına basıldığında, tüm uygulama arayüzü göz yormayan karanlık veya aydınlık renk paletlerine anında geçiş yapar.

---

## 📸 Ekran Görüntüleri ve Arayüz

| Yeni Not Ekleme (Aydınlık) | Yeni Not Ekleme (Karanlık) | Başarılı Kayıt Bildirimi |
|:---:|:---:|:---:|
| ![Ekleme Aydınlık](./screenshots/Screenshot_20260521_232809.png) | ![Ekleme Karanlık](./screenshots/Screenshot_20260521_232816.png) | ![Başarılı Alert](./screenshots/Screenshot_20260521_232948.png) |

| Not Listesi ve To-Do (Karanlık) | Düzenleme Modalı | Not Listesi (Aydınlık) |
|:---:|:---:|:---:|
| ![Liste Karanlık](./screenshots/Screenshot_20260521_232846.png) | ![Modal Edit](./screenshots/Screenshot_20260521_232916.png) | ![Liste Aydınlık](./screenshots/Screenshot_20260521_233017.png) |

---

## 📂 Dosya ve Klasör Mimarisi

```text
GunlukAjandam/
├── src/
│   ├── db.js                 # SQLite bağlantı yönetimi, tablo oluşturma ve CRUD sorguları
│   ├── ThemeContext.js       # Global tema durumunu (Dark/Light) yöneten Context API
│   ├── AddNoteScreen.js      # Veri giriş paneli, form validasyonu ve Kaydetme arayüzü
│   └── ListNotesScreen.js    # Veri listeleme, To-Do (Tamamlandı) mantığı ve Düzenleme Modalı
├── App.tsx                   # Navigasyon (Stack) yapısı ve ThemeProvider kök dosyası
└── package.json              # Projenin kütüphane bağımlılıkları

## 🗄️ Veritabanı Şeması

Uygulamanın yerel SQLite üzerinde çalışan `notes` tablosu aşağıdaki ilişkisel sütun yapısına sahiptir:

| Sütun Adı | Veri Tipi | Özellikler | Açıklama |
| :--- | :--- | :--- | :--- |
| **id** | INTEGER | PRIMARY KEY AUTOINCREMENT | Her nota benzersiz bir numara verir, otomatik artar. |
| **message** | TEXT | NOT NULL | Kullanıcının yazdığı not/görev içeriğini saklar. |
| **isCompleted** | INTEGER | DEFAULT 0 | Görevin durumunu tutar (0: Yapılacak, 1: Tamamlandı). |

---

## 🛠️ Kurulum ve Çalıştırma

Projeyi kendi yerel bilgisayarınızda (Android emülatör veya fiziksel cihaz üzerinde) çalıştırmak için sırasıyla aşağıdaki adımları izleyin:

**1. Proje Bağımlılıklarını ve Paketleri Yükleyin:**
```bash
npm install