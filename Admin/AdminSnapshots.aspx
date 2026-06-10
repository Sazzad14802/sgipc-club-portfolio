<%@ Page Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="AdminSnapshots.aspx.cs" Inherits="AdminSnapshots" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-heading">
        <p class="chip">Manage</p>
        <h1>Snapshots</h1>
        <asp:Label ID="messageLabel" runat="server" CssClass="form-status" />
    </div>

    <section class="admin-panel">
        <h2>Add Snapshot</h2>
        <div class="admin-grid">
            <div>
                <label for="snapshotValueTextBox">Value</label>
                <asp:TextBox ID="snapshotValueTextBox" runat="server" ClientIDMode="Static" />
            </div>
            <div>
                <label for="snapshotDescriptionTextBox">Description</label>
                <asp:TextBox ID="snapshotDescriptionTextBox" runat="server" ClientIDMode="Static" TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
            </div>
            <div>
                <label for="snapshotOrderTextBox">Display Order</label>
                <asp:TextBox ID="snapshotOrderTextBox" runat="server" ClientIDMode="Static" TextMode="Number" Text="0" />
            </div>
        </div>
        <asp:Button ID="addSnapshotButton" runat="server" Text="Add Snapshot" OnClick="AddSnapshotButton_Click" />
    </section>

    <section class="admin-panel">
        <h2>Snapshot Table</h2>
        <div class="table-responsive">
            <asp:GridView ID="snapshotGridView" runat="server" CssClass="admin-table" AutoGenerateColumns="False" DataKeyNames="SnapshotId" OnRowEditing="SnapshotGridView_RowEditing" OnRowCancelingEdit="SnapshotGridView_RowCancelingEdit" OnRowUpdating="SnapshotGridView_RowUpdating" OnRowDeleting="SnapshotGridView_RowDeleting">
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
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
