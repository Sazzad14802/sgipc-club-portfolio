using System;
using System.Data;
using System.Data.SqlClient;

public static class PortfolioRepository
{
    public static DataTable GetSnapshots()
    {
        const string sql = "SELECT SnapshotId, MetricValue, Description, DisplayOrder, CreatedAt FROM Snapshot ORDER BY DisplayOrder, SnapshotId";
        return FillTable(sql);
    }

    public static DataTable GetAchievements()
    {
        const string sql = "SELECT AchievementId, Title, Description, DisplayOrder, CreatedAt FROM Achievements ORDER BY DisplayOrder, AchievementId";
        return FillTable(sql);
    }

    public static void InsertSnapshot(string metricValue, string description, int displayOrder)
    {
        const string sql = "INSERT INTO Snapshot (MetricValue, Description, DisplayOrder) VALUES (@MetricValue, @Description, @DisplayOrder)";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@MetricValue", SqlDbType.NVarChar, 80).Value = metricValue;
            command.Parameters.Add("@Description", SqlDbType.NVarChar, 300).Value = description;
            command.Parameters.Add("@DisplayOrder", SqlDbType.Int).Value = displayOrder;
        });
    }

    public static void UpdateSnapshot(int snapshotId, string metricValue, string description, int displayOrder)
    {
        const string sql = "UPDATE Snapshot SET MetricValue = @MetricValue, Description = @Description, DisplayOrder = @DisplayOrder WHERE SnapshotId = @SnapshotId";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@MetricValue", SqlDbType.NVarChar, 80).Value = metricValue;
            command.Parameters.Add("@Description", SqlDbType.NVarChar, 300).Value = description;
            command.Parameters.Add("@DisplayOrder", SqlDbType.Int).Value = displayOrder;
            command.Parameters.Add("@SnapshotId", SqlDbType.Int).Value = snapshotId;
        });
    }

    public static void DeleteSnapshot(int snapshotId)
    {
        const string sql = "DELETE FROM Snapshot WHERE SnapshotId = @SnapshotId";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@SnapshotId", SqlDbType.Int).Value = snapshotId;
        });
    }

    public static void InsertAchievement(string title, string description, int displayOrder)
    {
        const string sql = "INSERT INTO Achievements (Title, Description, DisplayOrder) VALUES (@Title, @Description, @DisplayOrder)";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@Title", SqlDbType.NVarChar, 160).Value = title;
            command.Parameters.Add("@Description", SqlDbType.NVarChar, 800).Value = description;
            command.Parameters.Add("@DisplayOrder", SqlDbType.Int).Value = displayOrder;
        });
    }

    public static void UpdateAchievement(int achievementId, string title, string description, int displayOrder)
    {
        const string sql = "UPDATE Achievements SET Title = @Title, Description = @Description, DisplayOrder = @DisplayOrder WHERE AchievementId = @AchievementId";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@Title", SqlDbType.NVarChar, 160).Value = title;
            command.Parameters.Add("@Description", SqlDbType.NVarChar, 800).Value = description;
            command.Parameters.Add("@DisplayOrder", SqlDbType.Int).Value = displayOrder;
            command.Parameters.Add("@AchievementId", SqlDbType.Int).Value = achievementId;
        });
    }

    public static void DeleteAchievement(int achievementId)
    {
        const string sql = "DELETE FROM Achievements WHERE AchievementId = @AchievementId";

        ExecuteNonQuery(sql, command =>
        {
            command.Parameters.Add("@AchievementId", SqlDbType.Int).Value = achievementId;
        });
    }

    private static DataTable FillTable(string sql)
    {
        using (SqlConnection connection = Database.CreateConnection())
        using (SqlDataAdapter adapter = new SqlDataAdapter(sql, connection))
        {
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
    }

    private static void ExecuteNonQuery(string sql, Action<SqlCommand> addParameters)
    {
        using (SqlConnection connection = Database.CreateConnection())
        using (SqlCommand command = new SqlCommand(sql, connection))
        {
            addParameters(command);
            connection.Open();
            command.ExecuteNonQuery();
        }
    }
}
