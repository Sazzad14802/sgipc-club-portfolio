using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminEvents : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.Form != null)
        {
            Page.Form.Enctype = "multipart/form-data";
        }
        
        // Force full postbacks for these controls to bypass the UpdatePanel
        // so that the FileUpload control can successfully transmit the file byte stream.
        ScriptManager sm = ScriptManager.GetCurrent(this.Page);
        if (sm != null)
        {
            sm.RegisterPostBackControl(addEventButton);
        }

        if (!IsPostBack)
        {
            BindTables();
        }
    }

    protected void AddEventButton_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(eventTitleTextBox.Text) || string.IsNullOrWhiteSpace(eventDescriptionTextBox.Text))
        {
            ShowError("Title and Description are required.");
            return;
        }

        int displayOrder;
        if (!int.TryParse(eventOrderTextBox.Text, out displayOrder))
        {
            displayOrder = 0;
        }

        try
        {
            string imageUrl = string.Empty;
            if (eventImageUpload.HasFile)
            {
                imageUrl = HandleImageUpload(eventImageUpload, string.Empty);
            }

            PortfolioRepository.InsertEvent(
                eventTitleTextBox.Text.Trim(),
                eventDescriptionTextBox.Text.Trim(),
                imageUrl,
                displayOrder
            );
            
            ShowSuccess("Event added successfully.");
            
            eventTitleTextBox.Text = string.Empty;
            eventDescriptionTextBox.Text = string.Empty;
            eventOrderTextBox.Text = "0";

            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Database error: " + ex.Message);
        }
    }

    protected void EventsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        eventsGridView.EditIndex = e.NewEditIndex;
        BindTables();
    }

    protected void EventsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        eventsGridView.EditIndex = -1;
        BindTables();
    }

    protected void EventsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int eventId = Convert.ToInt32(eventsGridView.DataKeys[e.RowIndex].Value);
        
        TextBox editTitleTextBox = (TextBox)eventsGridView.Rows[e.RowIndex].FindControl("editTitleTextBox");
        TextBox editDescriptionTextBox = (TextBox)eventsGridView.Rows[e.RowIndex].FindControl("editDescriptionTextBox");
        FileUpload editImageUpload = (FileUpload)eventsGridView.Rows[e.RowIndex].FindControl("editImageUpload");
        HiddenField hfExistingImage = (HiddenField)eventsGridView.Rows[e.RowIndex].FindControl("hfExistingImage");
        int displayOrder = Convert.ToInt32(e.NewValues["DisplayOrder"] ?? 0);

        try
        {
            string finalImageUrl = HandleImageUpload(editImageUpload, hfExistingImage.Value);

            PortfolioRepository.UpdateEvent(
                eventId,
                editTitleTextBox.Text.Trim(),
                editDescriptionTextBox.Text.Trim(),
                finalImageUrl,
                displayOrder
            );
            
            eventsGridView.EditIndex = -1;
            ShowSuccess("Event updated successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Event update error: " + ex.Message);
        }
    }

    protected void EventsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int eventId = Convert.ToInt32(eventsGridView.DataKeys[e.RowIndex].Value);
        
        // Find the image URL so we can delete it from storage if it's an uploaded file
        Label lblImage = (Label)eventsGridView.Rows[e.RowIndex].FindControl("lblImage");
        string imageUrl = lblImage != null ? lblImage.Text : string.Empty;

        try
        {
            PortfolioRepository.DeleteEvent(eventId);
            DeleteOldImage(imageUrl);

            ShowSuccess("Event deleted successfully.");
            BindTables();
        }
        catch (Exception ex)
        {
            ShowError("Event delete error: " + ex.Message);
        }
    }

    protected void EventsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // Only target the row that is currently in Edit mode
        if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
        {
            // Find the custom Update button we added to the TemplateField
            Button btnUpdate = (Button)e.Row.FindControl("btnUpdate");
            ScriptManager sm = ScriptManager.GetCurrent(this.Page);
            
            // Explicitly force the Update button to do a full page refresh 
            // so the FileUpload byte stream survives the submit process.
            if (btnUpdate != null && sm != null)
            {
                sm.RegisterPostBackControl(btnUpdate);
            }
        }
    }

    private void BindTables()
    {
        try
        {
            eventsGridView.DataSource = PortfolioRepository.GetEvents();
            eventsGridView.DataBind();
        }
        catch (Exception ex)
        {
            ShowError("Database error: " + ex.Message);
        }
    }

    private void ShowSuccess(string message)
    {
        messageLabel.CssClass = "form-status";
        messageLabel.Text = message;
        messageLabel.Style.Remove("color");
    }

    private void ShowError(string message)
    {
        messageLabel.CssClass = "validation-message";
        messageLabel.Text = message;
        messageLabel.Style["color"] = "var(--danger, red)";
    }

    private string HandleImageUpload(FileUpload fileUpload, string existingImageUrl)
    {
        if (fileUpload.HasFile)
        {
            string extension = System.IO.Path.GetExtension(fileUpload.FileName).ToLower();
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
            if (Array.IndexOf(allowedExtensions, extension) >= 0)
            {
                string newFileName = Guid.NewGuid().ToString() + extension;
                string savePath = Server.MapPath("~/Assets/Uploads/") + newFileName;
                fileUpload.SaveAs(savePath);
                
                // Safely delete the old image to free up space
                DeleteOldImage(existingImageUrl);

                return "Assets/Uploads/" + newFileName;
            }
            else
            {
                throw new Exception("Invalid file type. Only image files are allowed.");
            }
        }
        return existingImageUrl;
    }

    private void DeleteOldImage(string imageUrl)
    {
        // Only delete files that are inside the Uploads directory
        if (!string.IsNullOrWhiteSpace(imageUrl) && imageUrl.StartsWith("Assets/Uploads/"))
        {
            try
            {
                string fullPath = Server.MapPath("~/" + imageUrl);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }
            }
            catch
            {
                // Silently ignore if file is locked or already deleted
            }
        }
    }
}
