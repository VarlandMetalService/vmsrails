class SaltSprayTest < ApplicationRecord
  # Associations.
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :on_user   , class_name: "User"
  has_one :off_user  , class_name: "User"
  has_one :red_user  , class_name: "User"
  has_one :white_user, class_name: "User"

  # Validations.
  validates_presence_of :so_num, :load_num
end