/**
 * Object for working with Trix file uploads.
 */
var TrixHandler = {

  /**
   * @var temporarilyAdded    Stores IDs of attachments added to editor.
   * @var temporarilyRemoved  Stores IDs of attachments removed from editor.
   */
  temporarilyAdded: null,
  temporarilyRemoved: null,

  /**
   * Uploads attachment.
   * 
   * @param   attachment    Attachment to be uploaded.
   * @param   formID        ID of form containing editor.
   * @returns xhr.send
   */
  uploadAttachment: function(attachment, formID) {

    // If array of temporarily added objects does not exist for form, create it.
    if (!(formID in TrixHandler.temporarilyAdded)) {
      TrixHandler.temporarilyAdded[formID] = new Array();
    }

    // Add uploaded file to FormData object.
    var file = attachment.file;
    var form = new FormData;
    form.append("Content-Type", file.type);
    form.append("inline_attachment[file]", file);
  
    // Configure XHR request.
    var xhr = new XMLHttpRequest;
    xhr.open("POST", "/inline_attachments.json", true);
    xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());
  
    // Setup progress callback to update Trix Editor progress bar.
    xhr.upload.onprogress = function(event) {
      progress = event.loaded / event.total * 100;
      attachment.setUploadProgress(progress);
    }
  
    // Configure handler for successful completion of XHR request.
    xhr.onload = function() {
      if (xhr.status === 201) {
        var data = JSON.parse(xhr.responseText);
        TrixHandler.temporarilyAdded[formID].push(data.id);
        return attachment.setAttributes({
          url: data.image_url,
          href: data.image_url
        });
      }
    }
  
    // Send XHR request and return result.
    return xhr.send(form);

  },

  /**
   * Removes attachment.
   * 
   * @param   attachment    Attachment ID to be removed.
   * @returns xhr.send
   */
  removeAttachment: function(attachment) {

    // Configure XHR request.    
    var xhr = new XMLHttpRequest;
    xhr.open("DELETE", "/inline_attachments/" + attachment + ".json", true);
    xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());
  
    // Send XHR request and return result.
    return xhr.send();

  },

  /**
   * Removes all temporarily removed attachments.
   * 
   * @param   formID        ID of form containing editor.
   * @return  void
   */
  removeAllTemporarilyRemovedAttachments: function(formID) {

    // If no temporarily removed attachments for form, return.
    if (!(formID in TrixHandler.temporarilyRemoved)) return;

    // Remove each attachment.
    for (var i = 0, c = TrixHandler.temporarilyRemoved[formID].length; i < c; i++) {
      TrixHandler.removeAttachment(TrixHandler.temporarilyRemoved[formID][i]);
    }

  },

  /**
   * Removes all temporarily added attachments.
   * 
   * @param   formID        ID of form containing editor.
   * @return  void
   */
  removeAllTemporarilyAddedAttachments: function(formID) {

    // If no temporarily added attachments for form, return.
    if (!(formID in TrixHandler.temporarilyAdded)) return;

    // Remove each attachment.
    for (var i = 0, c = TrixHandler.temporarilyAdded[formID].length; i < c; i++) {
      TrixHandler.removeAttachment(TrixHandler.temporarilyAdded[formID][i]);
    }

  },

  /**
   * Extracts attachment ID from URL.
   * 
   * @param   url   URL to inline_attachment.
   * @returns int
   */
  extractID: function(url) {

    // Initialize regex for extracting ID.
    var extractionRegex = /^\/uploads\/inline_attachments\/(\d+)\/.*$/gi;
    var m = null;
  
    // As long as regular expression matches, return first capturing group.
    while ((m = extractionRegex.exec(url)) !== null) {
      if (m.index === extractionRegex.lastIndex) { extractionRegex.lastIndex++; }
      return parseInt(m[1]);
    }

  },

  /**
   * Initializes objects and configured the Trix editor.
   * 
   * @return void
   */
  initialize: function() {

    // Initialize arrays.
    TrixHandler.temporarilyAdded = {};
    TrixHandler.temporarilyRemoved = {};

    // Configure Trix captions.
    Trix.config.attachments.preview.caption = {
      name: false,
      size: false
    };

    // Configure handlers.
    $(document).on('trix-attachment-add', function(event) {
      var attachment = event.originalEvent.attachment;
      var formID = $(event.target).closest('form').attr('id');
      if (attachment.file) {
        return TrixHandler.uploadAttachment(attachment, formID);
      }
    });
    $(document).on('trix-attachment-remove', function(event) {
      var attachment = event.originalEvent.attachment;
      var formID = $(event.target).closest('form').attr('id');
      if (!(formID in TrixHandler.temporarilyRemoved)) {
        TrixHandler.temporarilyRemoved[formID] = new Array();
      }
      TrixHandler.temporarilyRemoved[formID].push(TrixHandler.extractID(attachment.attachment.previewURL));
    });
    $(document).on('submit', function(event) {
      var formID = $(event.target).attr('id');
      TrixHandler.removeAllTemporarilyRemovedAttachments(formID);
    });
    $(document).on('click', '.form-cancel-button', function(event) {
      var formID = $(event.target).closest('form').attr('id');
      TrixHandler.removeAllTemporarilyAddedAttachments(formID);
    });

  },

};
TrixHandler.initialize();