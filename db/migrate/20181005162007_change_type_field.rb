class ChangeTypeField < ActiveRecord::Migration[5.1]
  def change
    rename_column :salt_spray_test_checks, :type, :c_type
  end
end
