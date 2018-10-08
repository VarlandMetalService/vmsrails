class SaltSprayTestCheck < ApplicationRecord
  belongs_to :salt_spray_test, optional: :true, class_name: "SaltSprayTest" 
  belongs_to :user, foreign_key: "user_id", class_name: "User"
end