using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminAchievements : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindTables();
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

    private void BindTables()
    {
        try
        {
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
        foreach (Control control in row.Cells[cellIndex].Controls)
        {
            TextBox textBox = control as TextBox;
            if (textBox != null)
            {
                return textBox.Text.Trim();
            }
        }
        return string.Empty;
    }

    private static bool TryReadDisplayOrder(string value, out int displayOrder)
    {
        return int.TryParse(value, out displayOrder);
    }

    private void ShowSuccess(string message)
    {
        messageLabel.CssClass = "form-status";
        messageLabel.Text = message;
        messageLabel.Style.Remove("color");
    }

    private void ShowError(string message)
    {
        messageLabel.CssClass = "validation-message";
        messageLabel.Text = message;
    }
}
