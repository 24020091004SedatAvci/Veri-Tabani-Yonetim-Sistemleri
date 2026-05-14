USE HastaneRandevuDB;
GO

INSERT INTO Clinics (KlinikAdi, KatNo, Uzmanlik) VALUES
(N'Kardiyoloji', 2, N'Kalp ve damar hastalıkları'),
(N'Ortopedi', 3, N'Kemik, eklem ve kas hastalıkları'),
(N'Nöroloji', 4, N'Sinir sistemi hastalıkları'),
(N'Dahiliye', 1, N'İç hastalıkları'),
(N'Göz Hastalıkları', 2, N'Göz sağlığı ve görme bozuklukları'),
(N'Kulak Burun Boğaz', 3, N'KBB hastalıkları');
GO

INSERT INTO Doctors (KlinikID, AdSoyad, Unvan) VALUES
(1, N'Dr. Ahmet Yılmaz', N'Kardiyoloji Uzmanı'),
(1, N'Dr. Elif Demir', N'Uzman Doktor'),
(2, N'Dr. Mehmet Kaya', N'Ortopedi Uzmanı'),
(2, N'Dr. Selin Arslan', N'Operatör Doktor'),
(3, N'Dr. Burak Çelik', N'Nöroloji Uzmanı'),
(3, N'Dr. Zeynep Aydın', N'Uzman Doktor'),
(4, N'Dr. Murat Şahin', N'Dahiliye Uzmanı'),
(4, N'Dr. Ayşe Koç', N'Uzman Doktor'),
(5, N'Dr. Emre Yıldız', N'Göz Hastalıkları Uzmanı'),
(6, N'Dr. Deniz Kara', N'KBB Uzmanı');
GO

INSERT INTO Patients (TCKimlik, AdSoyad, Telefon, KanGrubu) VALUES
(N'12345678901', N'Ali Veli', N'05551112233', N'A+'),
(N'23456789012', N'Fatma Demir', N'05552223344', N'B+'),
(N'34567890123', N'Mehmet Yıldırım', N'05553334455', N'0+'),
(N'45678901234', N'Ayşe Kaya', N'05554445566', N'AB+'),
(N'56789012345', N'Hasan Çelik', N'05555556677', N'A-'),
(N'67890123456', N'Zeynep Arslan', N'05556667788', N'B-');
GO

INSERT INTO Appointments (HastaID, DoktorID, RandevuTarihi, Sikayet) VALUES
(1, 1, '2026-05-15 09:00:00', N'Göğüs ağrısı ve çarpıntı şikayeti'),
(2, 3, '2026-05-15 10:00:00', N'Diz ağrısı ve yürürken zorlanma'),
(3, 5, '2026-05-15 11:00:00', N'Baş ağrısı ve baş dönmesi'),
(4, 7, '2026-05-15 13:30:00', N'Mide ağrısı ve halsizlik'),
(5, 9, '2026-05-15 14:00:00', N'Görme bulanıklığı'),
(6, 10, '2026-05-15 15:00:00', N'Kulak ağrısı ve işitme azalması'),
(1, 2, '2026-05-16 09:30:00', N'Nefes darlığı kontrolü'),
(2, 4, '2026-05-16 11:30:00', N'Kol ağrısı ve hareket kısıtlılığı');
GO

INSERT INTO Prescriptions (RandevuID, IlacListesi, KullanimTalimati) VALUES
(1, N'Beloc 50 mg, Coraspin 100 mg', N'Beloc sabah 1 tablet, Coraspin tok karnına günde 1 tablet.'),
(2, N'Parol 500 mg, Kas gevşetici krem', N'Parol ağrı olduğunda kullanılacak. Krem günde 2 kez uygulanacak.'),
(3, N'Majezik 100 mg', N'Baş ağrısı olduğunda tok karnına alınacak.'),
(4, N'Rennie, Lansor', N'Lansor sabah aç karnına, Rennie ihtiyaç halinde kullanılacak.');
GO