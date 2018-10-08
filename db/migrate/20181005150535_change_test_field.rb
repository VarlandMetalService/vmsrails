class ChangeTestField < ActiveRecord::Migration[5.1]
  def change
    rename_column :salt_spray_test_checks, :test_id, :salt_spray_test_id
  end
end
