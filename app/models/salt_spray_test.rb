class SaltSprayTest < ApplicationRecord
  acts_as_paranoid
  # Associations.
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :salt_spray_test_checks, class_name: "SaltSprayTestCheck", dependent: :destroy 
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  accepts_nested_attributes_for :salt_spray_test_checks

  # Validations.
  validates_presence_of :so_num, :load_num

  scope :with_process_code, ->(process_code) { where("process_code = ?", process_code) unless process_code.nil? }

  def self.options_for_process_code
    [['HN', 'HN'],
     ['ZN', 'ZN']]
  end

  def self.not_recently
    preload(:salt_spray_test_checks).select { |s| s.salt_spray_test_checks.all? {|c| ((Time.now - c.date) > 4.hours) }}
  end
end