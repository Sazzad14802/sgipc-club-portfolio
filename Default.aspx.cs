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
    }

    private void BindPortfolioContent()
    {
        statsRepeater.DataSource = PortfolioRepository.GetSnapshots();
        statsRepeater.DataBind();

        achievementsRepeater.DataSource = PortfolioRepository.GetAchievements();
        achievementsRepeater.DataBind();
    }
}
