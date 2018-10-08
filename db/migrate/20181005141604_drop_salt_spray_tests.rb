class DropSaltSprayTests < ActiveRecord::Migration[5.1]
  def change
    drop_table :salt_spray_tests
  end
end
