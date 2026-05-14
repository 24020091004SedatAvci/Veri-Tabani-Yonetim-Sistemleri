CREATE DATABASE HastaneRandevuDB;
GO

USE HastaneRandevuDB;
GO

CREATE TABLE Clinics (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    KlinikAdi NVARCHAR(100) NOT NULL,
    KatNo INT NOT NULL,
    Uzmanlik NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Doctors (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    KlinikID INT NOT NULL,
    AdSoyad NVARCHAR(150) NOT NULL,
    Unvan NVARCHAR(100) NOT NULL,

    CONSTRAINT FK_Doctors_Clinics
        FOREIGN KEY (KlinikID)
        REFERENCES Clinics(ID)
        ON DELETE CASCADE
);
GO

CREATE TABLE Patients (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TCKimlik NVARCHAR(11) NOT NULL UNIQUE,
    AdSoyad NVARCHAR(150) NOT NULL,
    Telefon NVARCHAR(20) NOT NULL,
    KanGrubu NVARCHAR(10) NOT NULL
);
GO

CREATE TABLE Appointments (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    HastaID INT NOT NULL,
    DoktorID INT NOT NULL,
    RandevuTarihi DATETIME NOT NULL,
    Sikayet NVARCHAR(MAX) NOT NULL,

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (HastaID)
        REFERENCES Patients(ID)
        ON DELETE CASCADE,

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoktorID)
        REFERENCES Doctors(ID)
        ON DELETE CASCADE,

    CONSTRAINT UQ_Doctor_Appointment_Time
        UNIQUE (DoktorID, RandevuTarihi)
);
GO

CREATE TABLE Prescriptions (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    RandevuID INT NOT NULL UNIQUE,
    IlacListesi NVARCHAR(MAX) NOT NULL,
    KullanimTalimati NVARCHAR(MAX) NOT NULL,

    CONSTRAINT FK_Prescriptions_Appointments
        FOREIGN KEY (RandevuID)
        REFERENCES Appointments(ID)
        ON DELETE CASCADE
);
GO