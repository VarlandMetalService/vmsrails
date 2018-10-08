class DefaultValuesForSpecs < ActiveRecord::Migration[5.1]
  def change
      change_column :salt_spray_tests, :white_spec, :integer, :default => 1
      change_column :salt_spray_tests, :red_spec, :integer, :default => 1
  end
end
