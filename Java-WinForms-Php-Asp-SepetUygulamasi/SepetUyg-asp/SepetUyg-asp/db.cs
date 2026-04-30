using System;
using System.Data.SqlClient;

public class VeriTabani
{
    public static SqlConnection BaglantiAl()
    {
        // Kendi kullanıcı adın ve şifrenle bağlantıyı kuruyoruz
        string connStr = "Server=localhost; Database=SepetDB; User Id=Sedat; Password=1512; TrustServerCertificate=True;";
        return new SqlConnection(connStr);
    }
}