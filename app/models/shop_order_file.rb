class ShopOrderFile < ApplicationRecord
  mount_uploaders :file, FileUploader, file_name: -> (u) { u.created_at }
  serialize :file, JSON

  validates :so_num, presence: true
  validates :file, presence: true

  scope :with_so_num, ->(so_num) { where("so_num = ?", so_num) unless so_num.blank? }

  
end
