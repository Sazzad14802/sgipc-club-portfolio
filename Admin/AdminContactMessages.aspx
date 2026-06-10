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
        <h2 id="messagesCountHeading" runat="server">Contact Messages</h2>
        <div class="table-responsive">
            <asp:GridView ID="contactMessagesGridView" runat="server" CssClass="admin-table" AutoGenerateColumns="False" DataKeyNames="ContactMessageId" OnRowDeleting="ContactMessagesGridView_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" ReadOnly="True" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" />
                    <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Message">
                        <ItemTemplate>
                            <div style="max-height: 150px; overflow-y: auto; white-space: pre-wrap;"><%# Eval("Message") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this message? This action cannot be undone.');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
