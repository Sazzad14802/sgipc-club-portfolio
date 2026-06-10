<%@ Page Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="AdminAchievements.aspx.cs" Inherits="AdminAchievements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-heading">
        <p class="chip">Manage</p>
        <h1>Achievements</h1>
        <asp:Label ID="messageLabel" runat="server" CssClass="form-status" />
    </div>

    <section class="admin-panel">
        <h2>Add Achievement</h2>
        <div class="admin-grid">
            <div>
                <label for="achievementTitleTextBox">Title</label>
                <asp:TextBox ID="achievementTitleTextBox" runat="server" ClientIDMode="Static" TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
            </div>
            <div>
                <label for="achievementDescriptionTextBox">Description</label>
                <asp:TextBox ID="achievementDescriptionTextBox" runat="server" ClientIDMode="Static" TextMode="MultiLine" />
            </div>
            <div>
                <label for="achievementOrderTextBox">Display Order</label>
                <asp:TextBox ID="achievementOrderTextBox" runat="server" ClientIDMode="Static" TextMode="Number" Text="0" />
            </div>
        </div>
        <asp:Button ID="addAchievementButton" runat="server" Text="Add Achievement" OnClick="AddAchievementButton_Click" />
    </section>

    <section class="admin-panel">
        <h2>Achievements Table</h2>
        <div class="table-responsive">
            <asp:GridView ID="achievementsGridView" runat="server" CssClass="admin-table" AutoGenerateColumns="False" DataKeyNames="AchievementId" OnRowEditing="AchievementsGridView_RowEditing" OnRowCancelingEdit="AchievementsGridView_RowCancelingEdit" OnRowUpdating="AchievementsGridView_RowUpdating" OnRowDeleting="AchievementsGridView_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="AchievementId" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Title">
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="editTitleTextBox" runat="server" Text='<%# Bind("Title") %>' TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="editDescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DisplayOrder" HeaderText="Display Order" />
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
