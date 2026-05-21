using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            BindTables();
        }
    }

    protected void AddSnapshotButton_Click(object sender, EventArgs e)
    {
        int displayOrder;
        if (!TryReadDisplayOrder(snapshotOrderTextBox.Text, out displayOrder))
        {
            ShowError("Snapshot display order must be a number.");
            return;
        }

        if (string.IsNullOrWhiteSpace(snapshotValueTextBox.Text))
        {
            ShowError("Snapshot value is required.");
            return;
        }

        try
        {
            PortfolioRepository.InsertSnapshot(snapshotValueTextBox.Text.Trim(), snapshotDescriptionTextBox.Text.Trim(), displayOrder);
            snapshotValueTextBox.Text = string.Empty;
            snapshotDescriptionTextBox.Text = string.Empty;
            snapshotOrderTextBox.Text = "0";
            ShowSuccess("Snapshot added successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Snapshot insert error: " + ex.Message);
        }
    }

    protected void AddAchievementButton_Click(object sender, EventArgs e)
    {
        int displayOrder;
        if (!TryReadDisplayOrder(achievementOrderTextBox.Text, out displayOrder))
        {
            ShowError("Achievement display order must be a number.");
            return;
        }

        if (string.IsNullOrWhiteSpace(achievementTitleTextBox.Text))
        {
            ShowError("Achievement title is required.");
            return;
        }

        try
        {
            PortfolioRepository.InsertAchievement(achievementTitleTextBox.Text.Trim(), achievementDescriptionTextBox.Text.Trim(), displayOrder);
            achievementTitleTextBox.Text = string.Empty;
            achievementDescriptionTextBox.Text = string.Empty;
            achievementOrderTextBox.Text = "0";
            ShowSuccess("Achievement added successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Achievement insert error: " + ex.Message);
        }
    }

    protected void SnapshotGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        snapshotGridView.EditIndex = e.NewEditIndex;
        BindTables();
    }

    protected void SnapshotGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        snapshotGridView.EditIndex = -1;
        BindTables();
    }

    protected void SnapshotGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int snapshotId = Convert.ToInt32(snapshotGridView.DataKeys[e.RowIndex].Value);
        GridViewRow row = snapshotGridView.Rows[e.RowIndex];

        string metricValue = ReadEditedCell(row, 1);
        string description = ReadEditedCell(row, 2);

        int displayOrder;
        if (!TryReadDisplayOrder(ReadEditedCell(row, 3), out displayOrder))
        {
            ShowError("Snapshot display order must be a number.");
            return;
        }

        try
        {
            PortfolioRepository.UpdateSnapshot(snapshotId, metricValue, description, displayOrder);
            snapshotGridView.EditIndex = -1;
            ShowSuccess("Snapshot updated successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Snapshot update error: " + ex.Message);
        }
    }

    protected void SnapshotGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int snapshotId = Convert.ToInt32(snapshotGridView.DataKeys[e.RowIndex].Value);

        try
        {
            PortfolioRepository.DeleteSnapshot(snapshotId);
            ShowSuccess("Snapshot deleted successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Snapshot delete error: " + ex.Message);
        }
    }

    protected void AchievementsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        achievementsGridView.EditIndex = e.NewEditIndex;
        BindTables();
    }

    protected void AchievementsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        achievementsGridView.EditIndex = -1;
        BindTables();
    }

    protected void AchievementsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int achievementId = Convert.ToInt32(achievementsGridView.DataKeys[e.RowIndex].Value);
        GridViewRow row = achievementsGridView.Rows[e.RowIndex];

        string title = ReadEditedCell(row, 1);
        string description = ReadEditedCell(row, 2);

        int displayOrder;
        if (!TryReadDisplayOrder(ReadEditedCell(row, 3), out displayOrder))
        {
            ShowError("Achievement display order must be a number.");
            return;
        }

        try
        {
            PortfolioRepository.UpdateAchievement(achievementId, title, description, displayOrder);
            achievementsGridView.EditIndex = -1;
            ShowSuccess("Achievement updated successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Achievement update error: " + ex.Message);
        }
    }

    protected void AchievementsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int achievementId = Convert.ToInt32(achievementsGridView.DataKeys[e.RowIndex].Value);

        try
        {
            PortfolioRepository.DeleteAchievement(achievementId);
            ShowSuccess("Achievement deleted successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Achievement delete error: " + ex.Message);
        }
    }

    protected void LogoutButton_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Login.aspx");
    }

    private void BindTables()
    {
        try
        {
            snapshotGridView.DataSource = PortfolioRepository.GetSnapshots();
            snapshotGridView.DataBind();

            achievementsGridView.DataSource = PortfolioRepository.GetAchievements();
            achievementsGridView.DataBind();
        }
        catch (Exception ex)
        {
            ShowError("Database error: " + ex.Message);
        }
    }

    private static string ReadEditedCell(GridViewRow row, int cellIndex)
    {
        TextBox textBox = row.Cells[cellIndex].Controls[0] as TextBox;
        return textBox == null ? string.Empty : textBox.Text.Trim();
    }

    private static bool TryReadDisplayOrder(string value, out int displayOrder)
    {
        return int.TryParse(value, out displayOrder);
    }

    private void ShowSuccess(string message)
    {
        messageLabel.CssClass = "form-status";
        messageLabel.Text = message;
    }

    private void ShowError(string message)
    {
        messageLabel.CssClass = "validation-message";
        messageLabel.Text = message;
    }
}
