<?php
require_once "baglanti.php";

if (!isset($_GET["id"]) || !is_numeric($_GET["id"])) {
    header("Location: film-yonetim.php");
    exit;
}

$id = intval($_GET["id"]);

try {
    $conn->beginTransaction();

    $stmtCast = $conn->prepare("
    DELETE FROM film_oyunculari 
    WHERE film_id = ?
    ");

    $stmtCast->execute([$id]);

    $stmtFilm = $conn->prepare("
    DELETE FROM filmler 
    WHERE id = ?
    ");

    $stmtFilm->execute([$id]);

    $conn->commit();

    header("Location: film-yonetim.php?mesaj=silindi");
    exit;

} catch (Exception $e) {
    $conn->rollBack();
    die("Film silinirken hata oluştu: " . $e->getMessage());
}