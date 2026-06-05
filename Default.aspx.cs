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

                formStatus.Text = "<div class=\"form-status\" style=\"color: #10b981; margin-top: 1rem;\">Message sent successfully! We will get back to you soon.</div>";
            }
            catch (Exception)
            {
                formStatus.Text = "<div class=\"validation-message\" style=\"margin-top: 1rem;\">An error occurred while sending your message. Please try again later.</div>";
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
