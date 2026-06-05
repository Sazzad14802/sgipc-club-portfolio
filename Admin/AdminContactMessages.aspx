<%@ Page Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="AdminContactMessages.aspx.cs" Inherits="AdminContactMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-heading">
        <p class="chip">Manage</p>
        <h1>Contact Messages</h1>
        <asp:Label ID="messageLabel" runat="server" CssClass="form-status" />
    </div>

    <section class="admin-panel">
        <h2>Contact Messages</h2>
        <asp:GridView ID="contactMessagesGridView" runat="server" CssClass="admin-table" AutoGenerateColumns="False" DataKeyNames="ContactMessageId" OnRowDeleting="ContactMessagesGridView_RowDeleting">
            <Columns>
                <asp:BoundField DataField="ContactMessageId" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" />
                <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />
                <asp:BoundField DataField="Subject" HeaderText="Subject" ReadOnly="True" />
                <asp:TemplateField HeaderText="Message">
                    <ItemTemplate>
                        <div style="max-height: 150px; overflow-y: auto; white-space: pre-wrap;"><%# Eval("Message") %></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CreatedAt" HeaderText="Received At" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </section>
</asp:Content>
