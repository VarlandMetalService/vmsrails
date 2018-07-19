Trix.config.attachments.preview.caption = {
  name: false,
  size: false
};

function uploadAttachment(attachment) {
  var file = attachment.file;
  var form = new FormData;
  form.append("Content-Type", file.type);
  form.append("inline_attachment[file]", file);

  var xhr = new XMLHttpRequest;
  xhr.open("POST", "/inline_attachments.json", true);
  xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());

  xhr.upload.onprogress = function(event) {
    progress = event.loaded / event.total * 100;
    attachment.setUploadProgress(progress);
  }

  xhr.onload = function() {
    if (xhr.status === 201) {
      var data = JSON.parse(xhr.responseText);
      return attachment.setAttributes({
        url: data.image_url,
        href: data.image_url
      });
    }
  }

  return xhr.send(form);
}

function removeAttachment(URL) {

  var extractionRegex = /^\/uploads\/inline_attachments\/(\d+)\/.*$/gi;
  var m = null;

  while ((m = extractionRegex.exec(URL)) !== null) {
    if (m.index === extractionRegex.lastIndex) { extractionRegex.lastIndex++; }
    var objectID = m[1];
    var xhr = new XMLHttpRequest;
    xhr.open("DELETE", "/inline_attachments/" + objectID + ".json", true);
    xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());
    return xhr.send();
  }

}

document.addEventListener("trix-attachment-add", function(event) {
  var attachment = event.attachment;
  if (attachment.file) {
    return uploadAttachment(attachment);
  }
});

document.addEventListener("trix-attachment-remove", function(event) {
  var attachment = event.attachment;
  return removeAttachment(attachment.attachment.previewURL);
});