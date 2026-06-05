<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Login - SGIPC</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&amp;family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="styles.css?v=2" />
</head>
<body>
  <form id="form1" runat="server">
    <main class="auth-shell">
      <section class="auth-card">
        <p class="chip">Admin Area</p>
        <h1>Portfolio Login</h1>
        <p>Sign in to edit public portfolio content.</p>

        <label for="username">Username</label>
        <asp:TextBox ID="username" runat="server" ClientIDMode="Static" />
        <asp:RequiredFieldValidator ID="usernameValidator" runat="server" ControlToValidate="username" CssClass="validation-message" ErrorMessage="Username is required." Display="Dynamic" />

        <label for="password">Password</label>
        <asp:TextBox ID="password" runat="server" ClientIDMode="Static" TextMode="Password" />
        <asp:RequiredFieldValidator ID="passwordValidator" runat="server" ControlToValidate="password" CssClass="validation-message" ErrorMessage="Password is required." Display="Dynamic" />
        <label class="remember-wrap">
            <input type="checkbox" id="rememberMe" runat="server" />
            <span>Remember me</span>
        </label>
        <asp:Button ID="loginButton" runat="server" Text="Login" OnClick="LoginButton_Click" />
        <asp:Literal ID="loginStatus" runat="server" />

        <a class="text-link" href="Default.aspx">Back to portfolio</a>
      </section>
    </main>
  </form>
</body>
</html>
