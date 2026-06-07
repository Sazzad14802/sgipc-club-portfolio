using System;
using System.Web;
using System.Web.UI;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
        Response.Cache.SetNoServerCaching();

        if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
        {
            Response.Redirect("../Login.aspx");
        }
    }

    protected void LogoutButton_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        if (Request.Cookies["AdminAuth"] != null)
        {
            Response.Cookies["AdminAuth"].Expires = DateTime.Now.AddDays(-1);
        }
        Response.Redirect("../Login.aspx");
    }
}
