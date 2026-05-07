<?php
$serverName = "localhost";
$connectionInfo = array(
    "Database" => "SepetDB",
    "UID" => "Sedat", // Güncellendi
    "PWD" => "1512",  // Güncellendi
    "CharacterSet" => "UTF-8"
);

// Bağlantı başlatma
$conn = sqlsrv_connect($serverName, $connectionInfo);

if (!$conn) {
    echo "Bağlantı başarısız kanka! <br />";
    die(print_r(sqlsrv_errors(), true));
}
?>