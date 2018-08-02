class FixThicknessTables < ActiveRecord::Migration[5.1]
  def change
    rename_column :thickness_checks, :check_number, :check_num
    rename_column :thickness_checks, :thickness_blocks, :thickness 
  end
end
