class AddTimestampsToBlocksAndChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :thickness_blocks, :created_at, :datetime, null: false
    add_column :thickness_blocks, :updated_at, :datetime, null: false
    add_column :thickness_checks, :created_at, :datetime, null: false
    add_column :thickness_checks, :updated_at, :datetime, null: false
  end
end
