<%@ Page Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true" CodeFile="AdminEvents.aspx.cs" Inherits="AdminEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-heading">
        <p class="chip">Manage</p>
        <h1>Workshops & Events</h1>
        <asp:Label ID="messageLabel" runat="server" CssClass="form-status" />
    </div>

    <section class="admin-panel">
        <h2>Add Event</h2>
        <div class="admin-grid">
            <div>
                <label for="eventTitleTextBox">Title</label>
                <asp:TextBox ID="eventTitleTextBox" runat="server" ClientIDMode="Static" TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
            </div>
            <div>
                <label for="eventDescriptionTextBox">Description</label>
                <asp:TextBox ID="eventDescriptionTextBox" runat="server" ClientIDMode="Static" TextMode="MultiLine" CssClass="dynamic-textarea" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px';" />
            </div>
            <div>
                <label>Event Image (Optional)</label>
                <div class="file-upload-wrapper">
                    <label class="file-upload-label">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                        Choose File...
                        <asp:FileUpload ID="eventImageUpload" runat="server" ClientIDMode="Static" accept="image/*" CssClass="hidden-file-input" onchange="document.getElementById('uploadFileName').textContent = this.files.length > 0 ? this.files[0].name : 'No file chosen';" />
                    </label>
                    <span id="uploadFileName" class="file-name-display">No file chosen</span>
                </div>
            </div>
            <div>
                <label for="eventOrderTextBox">Display Order</label>
                <asp:TextBox ID="eventOrderTextBox" runat="server" ClientIDMode="Static" TextMode="Number" Text="0" />
            </div>
        </div>
        <div class="admin-actions">
            <asp:Button ID="addEventButton" runat="server" Text="Add Event" OnClick="AddEventButton_Click" />
        </div>
    </section>

    <section class="admin-panel">
        <h2>Events Table</h2>
        <div class="table-responsive">
            <asp:GridView ID="eventsGridView" runat="server" CssClass="admin-table" AutoGenerateColumns="False" DataKeyNames="EventId" OnRowEditing="EventsGridView_RowEditing" OnRowCancelingEdit="EventsGridView_RowCancelingEdit" OnRowUpdating="EventsGridView_RowUpdating" OnRowDeleting="EventsGridView_RowDeleting" OnRowDataBound="EventsGridView_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="EventId" HeaderText="ID" ReadOnly="True" />
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
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Label ID="lblImage" runat="server" Text='<%# Eval("ImageUrl") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:HiddenField ID="hfExistingImage" runat="server" Value='<%# Bind("ImageUrl") %>' />
                            <small style="display:block; margin-bottom:4px; color:var(--text-muted); word-break: break-all;">Current: <%# string.IsNullOrEmpty(Convert.ToString(Eval("ImageUrl"))) ? "None" : Eval("ImageUrl") %></small>
                            <label class="file-upload-label" style="padding: 0.3rem 0.6rem; font-size: 0.8rem; margin-top: 4px;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: text-bottom; margin-right: 4px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                                Upload New
                                <asp:FileUpload ID="editImageUpload" runat="server" accept="image/*" CssClass="hidden-file-input" onchange="this.nextElementSibling.textContent = this.files.length > 0 ? ' (' + this.files[0].name + ')' : '';" />
                                <span class="file-name-display" style="display:inline;"></span>
                            </label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DisplayOrder" HeaderText="Order" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" />
                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this event? This action cannot be undone.');" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" />
                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</asp:Content>
