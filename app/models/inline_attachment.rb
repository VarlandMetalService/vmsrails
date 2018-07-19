class InlineAttachment < ApplicationRecord

  # File uploaders.
  mount_uploader :file, InlineAttachmentUploader

end
