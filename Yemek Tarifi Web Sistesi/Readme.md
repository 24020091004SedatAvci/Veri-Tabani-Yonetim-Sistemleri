# 🍽️ Yemek Tarifi Web Sitesi 

Bu proje, web programlama dersi kapsamında hazırlanmış kapsamlı bir yemek tarifi platformudur. 

Projenin temel amacı, **aynı uygulamanın üç farklı web teknolojisi ve üç farklı ilişkisel veri tabanı ile sıfırdan geliştirilerek** pratik edilmesidir.

## 🚀 Proje Sürümleri

| Uygulama Teknolojisi | Kullanılan Veri Tabanı |
| :--- | :--- |
| **PHP** | MySQL |
| **JSP (Java Server Pages)** | PostgreSQL |
| **ASP.NET Web Forms** | Microsoft SQL Server (MSSQL) |

## ✨ Temel Özellikler (Tüm Sürümler İçin Ortak)
- 📋 **Listeleme:** Kayıtlı tariflerin ana sayfada listelenmesi.
- ➕ **Tarif Yönetimi:** Yeni tarif ekleme, mevcut tarifleri güncelleme ve silme (CRUD işlemleri).
- 🔍 **Detay Görünümü:** Yemeğin hazırlanış adımlarının ve detaylarının incelenmesi.
- 🛒 **Malzeme & Alışveriş:** Tariflere dinamik malzeme ekleme ve alışveriş listesi oluşturma.

## 🗄️ Veri Tabanı Mimarisi
Tüm projelerde ortak bir ilişkisel veri tabanı tasarımı kullanılmıştır. Veri tabanı oluşturma sorguları `database.sql` dosyasında bulunmaktadır. 

Ortak kullanılan tablolar:
* `kategoriler`
* `tarifler`
* `malzemeler`
* `tarif_malzemeleri`

## 📁 Klasör Yapısı

```text
YemekTarifiProjesi/
│
├── Readme.md
├── database.sql
│
├── yemek_tarifi-php/     # PHP sürümü kaynak kodları ve ekran görüntüleri
│
├── yemek_tarifi-jsp/     # JSP sürümü kaynak kodları ve ekran görüntüleri
│
└── yemek-tarifi-asp/     # ASP.NET sürümü kaynak kodları ve ekran görüntüleri
