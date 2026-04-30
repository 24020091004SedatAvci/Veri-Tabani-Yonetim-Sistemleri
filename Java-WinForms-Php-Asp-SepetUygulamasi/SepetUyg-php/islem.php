<?php
include 'db.php';

// --- MÜŞTERİ EKLEME ---
if(isset($_POST['m_ekle'])){
    $ad = $_POST['m_adi'];
    $durum = $_POST['durum'];
    $sql = "INSERT INTO müsteri (müsteri_adi, tarih, durum) VALUES (?, GETDATE(), ?)";
    sqlsrv_query($conn, $sql, array($ad, $durum));
    header("Location: index.php");
}

// --- ÜRÜN EKLEME ---
if(isset($_POST['u_ekle'])){
    $mid = $_POST['m_id'];
    $sql = "INSERT INTO sepet (müsteri_id, ürün_adi, fiyat, adet) VALUES (?, ?, ?, ?)";
    sqlsrv_query($conn, $sql, array($mid, $_POST['u_adi'], $_POST['u_fiyat'], $_POST['u_adet']));
    header("Location: index.php?m_id=$mid");
}

// --- MÜŞTERİ SİLME ---
if(isset($_GET['m_sil'])){
    $id = $_GET['m_sil'];
    // Önce o müşterinin sepetini temizleyelim
    sqlsrv_query($conn, "DELETE FROM sepet WHERE müsteri_id = ?", array($id));
    // Sonra müşteriyi silelim
    sqlsrv_query($conn, "DELETE FROM müsteri WHERE müsteri_id = ?", array($id));
    header("Location: index.php");
}

// --- ÜRÜN SİLME ---
if(isset($_GET['u_sil'])){
    $uid = $_GET['u_sil'];
    $mid = $_GET['m_id'];
    sqlsrv_query($conn, "DELETE FROM sepet WHERE ürün_id = ?", array($uid));
    header("Location: index.php?m_id=$mid");
}
?>