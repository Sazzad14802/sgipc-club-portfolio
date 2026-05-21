using System.Configuration;
using System.Data.SqlClient;

public static class Database
{
    public static SqlConnection CreateConnection()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PortfolioDb"].ConnectionString;
        return new SqlConnection(connectionString);
    }
}
