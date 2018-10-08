class ChangeProcessCode < ActiveRecord::Migration[5.1]
  def change
    change_column :salt_spray_tests, :process_code, :text
    rename_column :salt_spray_tests, :process_code, :process
  end
end
