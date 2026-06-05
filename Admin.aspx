<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard - SGIPC</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&amp;family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
      <form id="form1" runat="server">

      <asp:ScriptManager runat="server" />

      <asp:UpdatePanel runat="server">
        <ContentTemplate>

          <header class="site-header">
            <nav class="container nav-wrap" aria-label="Admin navigation">
              <a class="logo" href="Default.aspx">
                <img src="logo.png" alt="SGIPC Logo" />
              </a>

              <ul class="nav-links">
                <li><a href="Default.aspx">View Portfolio</a></li>

                <li>
                  <asp:LinkButton ID="logoutButton"
                    runat="server"
                    CausesValidation="false"
                    OnClick="LogoutButton_Click">
                    Logout
                  </asp:LinkButton>
                </li>
              </ul>
            </nav>
          </header>

          <main class="admin-shell">

            <section class="container">

              <div class="admin-heading">
                <p class="chip">Admin Dashboard</p>

                <h1>Manage Snapshot and Achievements</h1>

                <asp:Label ID="messageLabel"
                  runat="server"
                  CssClass="form-status" />
              </div>

              <section class="card admin-panel">
                <h2>Add Snapshot</h2>

                <div class="admin-grid">

                  <div>
                    <label for="snapshotValueTextBox">Value</label>

                    <asp:TextBox ID="snapshotValueTextBox"
                      runat="server"
                      ClientIDMode="Static" />
                  </div>

                  <div>
                    <label for="snapshotDescriptionTextBox">Description</label>

                    <asp:TextBox ID="snapshotDescriptionTextBox"
                      runat="server"
                      ClientIDMode="Static"
                      TextMode="MultiLine"
                      CssClass="dynamic-textarea"
                      oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
                  </div>

                  <div>
                    <label for="snapshotOrderTextBox">Display Order</label>

                    <asp:TextBox ID="snapshotOrderTextBox"
                      runat="server"
                      ClientIDMode="Static"
                      TextMode="Number"
                      Text="0" />
                  </div>

                </div>

                <asp:Button ID="addSnapshotButton"
                  runat="server"
                  Text="Add Snapshot"
                  OnClick="AddSnapshotButton_Click" />
              </section>

              <section class="card admin-panel">
                <h2>Snapshot Table</h2>

                <asp:GridView ID="snapshotGridView"
                  runat="server"
                  CssClass="admin-table"
                  AutoGenerateColumns="False"
                  DataKeyNames="SnapshotId"
                  OnRowEditing="SnapshotGridView_RowEditing"
                  OnRowCancelingEdit="SnapshotGridView_RowCancelingEdit"
                  OnRowUpdating="SnapshotGridView_RowUpdating"
                  OnRowDeleting="SnapshotGridView_RowDeleting">

                  <Columns>
                    <asp:BoundField DataField="SnapshotId" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="MetricValue" HeaderText="Value" />
                    <asp:TemplateField HeaderText="Description">
                      <ItemTemplate>
                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                      </ItemTemplate>
                      <EditItemTemplate>
                        <asp:TextBox ID="editDescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
                      </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DisplayOrder" HeaderText="Display Order" />

                    <asp:BoundField
                      DataField="CreatedAt"
                      HeaderText="Created At"
                      ReadOnly="True"
                      DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                    <asp:CommandField
                      ButtonType="Button"
                      ShowEditButton="True"
                      ShowDeleteButton="True" />
                  </Columns>

                </asp:GridView>
              </section>

              <section class="card admin-panel">
                <h2>Add Achievement</h2>

                <div class="admin-grid">

                  <div>
                    <label for="achievementTitleTextBox">Title</label>

                    <asp:TextBox ID="achievementTitleTextBox"
                      runat="server"
                      ClientIDMode="Static"
                      TextMode="MultiLine"
                      CssClass="dynamic-textarea"
                      oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
                  </div>

                  <div>
                    <label for="achievementDescriptionTextBox">Description</label>

                    <asp:TextBox ID="achievementDescriptionTextBox"
                      runat="server"
                      ClientIDMode="Static"
                      TextMode="MultiLine" />
                  </div>

                  <div>
                    <label for="achievementOrderTextBox">Display Order</label>

                    <asp:TextBox ID="achievementOrderTextBox"
                      runat="server"
                      ClientIDMode="Static"
                      TextMode="Number"
                      Text="0" />
                  </div>

                </div>

                <asp:Button ID="addAchievementButton"
                  runat="server"
                  Text="Add Achievement"
                  OnClick="AddAchievementButton_Click" />
              </section>

              <section class="card admin-panel">
                <h2>Achievements Table</h2>

                <asp:GridView ID="achievementsGridView"
                  runat="server"
                  CssClass="admin-table"
                  AutoGenerateColumns="False"
                  DataKeyNames="AchievementId"
                  OnRowEditing="AchievementsGridView_RowEditing"
                  OnRowCancelingEdit="AchievementsGridView_RowCancelingEdit"
                  OnRowUpdating="AchievementsGridView_RowUpdating"
                  OnRowDeleting="AchievementsGridView_RowDeleting">

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

                    <asp:BoundField
                      DataField="CreatedAt"
                      HeaderText="Created At"
                      ReadOnly="True"
                      DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                    <asp:CommandField
                      ButtonType="Button"
                      ShowEditButton="True"
                      ShowDeleteButton="True" />
                  </Columns>

                </asp:GridView>
              </section>

              <section class="card admin-panel">
                <h2>Contact Messages</h2>

                <asp:GridView ID="contactMessagesGridView"
                  runat="server"
                  CssClass="admin-table"
                  AutoGenerateColumns="False"
                  DataKeyNames="ContactMessageId"
                  OnRowDeleting="ContactMessagesGridView_RowDeleting">

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

                    <asp:BoundField
                      DataField="CreatedAt"
                      HeaderText="Received At"
                      ReadOnly="True"
                      DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                    <asp:CommandField
                      ButtonType="Button"
                      ShowDeleteButton="True" />
                  </Columns>

                </asp:GridView>
              </section>

            </section>

          </main>

        </ContentTemplate>
      </asp:UpdatePanel>

    </form>
</body>
</html>
