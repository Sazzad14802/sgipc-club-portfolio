using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminContactMessages : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindTables();
        }
    }

    protected void ContactMessagesGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int contactMessageId = Convert.ToInt32(contactMessagesGridView.DataKeys[e.RowIndex].Value);

        try
        {
            PortfolioRepository.DeleteContactMessage(contactMessageId);
            ShowSuccess("Contact message deleted successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Contact message delete error: " + ex.Message);
        }
    }

    private void BindTables()
    {
        try
        {
            contactMessagesGridView.DataSource = PortfolioRepository.GetContactMessages();
            contactMessagesGridView.DataBind();
        }
        catch (Exception ex)
        {
            ShowError("Database error: " + ex.Message);
        }
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
