class InlineAttachmentUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/inline_attachments/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end
  
end
