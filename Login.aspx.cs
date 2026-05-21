using System;
using System.Configuration;
using System.Web.UI;

public partial class Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"])
        {
            Response.Redirect("Admin.aspx");
        }
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        string configuredUsername = ConfigurationManager.AppSettings["AdminUsername"];
        string configuredPassword = ConfigurationManager.AppSettings["AdminPassword"];

        if (username.Text == configuredUsername && password.Text == configuredPassword)
        {
            Session["IsAdmin"] = true;
            Response.Redirect("Admin.aspx");
            return;
        }

        loginStatus.Text = "<p class=\"validation-message\">Invalid username or password.</p>";
    }
}
