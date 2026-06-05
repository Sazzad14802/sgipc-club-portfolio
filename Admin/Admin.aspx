<%@ Page Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-heading">
        <p class="chip">Admin Area</p>
        <h1>Welcome to the Admin Dashboard</h1>
    </div>

    <section class="admin-panel">
        <h2>Dashboard Overview</h2>
        <p>Please select an option from the navigation menu above to manage Snapshots, Achievements, or view Contact Messages.</p>
    </section>
</asp:Content>
