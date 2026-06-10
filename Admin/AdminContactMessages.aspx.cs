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
            var messagesTable = PortfolioRepository.GetContactMessages();
            contactMessagesGridView.DataSource = messagesTable;
            contactMessagesGridView.DataBind();

            int count = messagesTable.Rows.Count;
            if (count == 0)
            {
                messagesCountHeading.InnerText = "No messages";
            }
            else if (count == 1)
            {
                messagesCountHeading.InnerText = "1 message";
            }
            else
            {
                messagesCountHeading.InnerText = count + " messages";
            }
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
        messageLabel.Style.Remove("color");
    }

    private void ShowError(string message)
    {
        messageLabel.CssClass = "validation-message";
        messageLabel.Text = message;
    }
}
