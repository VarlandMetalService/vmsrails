class AddArchivedAtToSpecifications < ActiveRecord::Migration[5.1]
  def change
    add_column :specifications, :archived_at, :datetime
    add_index :specifications, :archived_at
  end
end
