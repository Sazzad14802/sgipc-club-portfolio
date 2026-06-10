using System;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPortfolioContent();
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                PortfolioRepository.InsertContactMessage(name.Text.Trim(), email.Text.Trim(), subject.Text.Trim(), message.Text.Trim());

                name.Text = string.Empty;
                email.Text = string.Empty;
                subject.Text = string.Empty;
                message.Text = string.Empty;

                ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('Message sent', 'success');", true);
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast", "showToast('An error occurred while sending your message. Please try again later.', 'error');", true);
            }
        }
    }

    private void BindPortfolioContent()
    {
        statsRepeater.DataSource = PortfolioRepository.GetSnapshots();
        statsRepeater.DataBind();

        achievementsRepeater.DataSource = PortfolioRepository.GetAchievements();
        achievementsRepeater.DataBind();
    }
}
