class ShopOrderFile < ApplicationRecord
  mount_uploader :file, FileUploader, file_name: -> (u) { u.created_at }

  validates :so_num, presence: true, shop_order: true
  validates :file, presence: true

  scope :with_so_num, ->(so_num) { where("so_num = ?", so_num) unless so_num.nil? }
end
