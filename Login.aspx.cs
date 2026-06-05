using System;
using System.Configuration;
using System.Web;
using System.Web.UI;

public partial class Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (Session["IsAdmin"] == null)
        {
            HttpCookie cookie = Request.Cookies["AdminAuth"];

            if (cookie != null && cookie.Value == "true")
            {
                Session["IsAdmin"] = true;
            }
        }

        if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"])
        {
            Response.Redirect("Admin/Admin.aspx");
        }
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        string configuredUsername = ConfigurationManager.AppSettings["AdminUsername"];
        string configuredPassword = ConfigurationManager.AppSettings["AdminPassword"];

        if (username.Text == configuredUsername && password.Text == configuredPassword)
        {
            Session["IsAdmin"] = true;

            if (rememberMe.Checked)
            {
                HttpCookie authCookie = new HttpCookie("AdminAuth");
                authCookie.Value = "true";
                authCookie.Expires = DateTime.Now.AddDays(7);

                Response.Cookies.Add(authCookie);
            }

            Response.Redirect("Admin/Admin.aspx");
            return;
        }

        loginStatus.Text = "<p class=\"validation-message\">Invalid username or password.</p>";
    }
}
