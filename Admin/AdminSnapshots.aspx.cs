using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSnapshots : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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

    private void BindTables()
    {
        try
        {
            snapshotGridView.DataSource = PortfolioRepository.GetSnapshots();
            snapshotGridView.DataBind();
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
    }

    private void ShowError(string message)
    {
        messageLabel.CssClass = "validation-message";
        messageLabel.Text = message;
    }
}
