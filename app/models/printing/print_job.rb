module Printing
  class PrintJob < ApplicationRecord
    mount_base64_uploader :file, PrintJobUploader, file_name: -> (u) { u.created_at }

    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_doc_type, ->(doc_type) { where("document_type_id = ?", doc_type) unless doc_type.nil? }
    scope :with_workstation, ->(workstation) { where("workstation_id = ?", workstation) unless workstation.nil? }
    scope :with_is_complete, ->(is_complete) { where("is_complete = false", is_complete) unless !is_complete.blank? }
  end
end 