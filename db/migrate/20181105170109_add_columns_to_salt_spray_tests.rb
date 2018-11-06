class AddColumnsToSaltSprayTests < ActiveRecord::Migration[5.1]
  def change
      add_column :salt_spray_tests, :is_sample, :boolean
      add_column :salt_spray_tests, :sample_code, :integer
  end
end
