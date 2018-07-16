class AddDeletedAtToSpecifications < ActiveRecord::Migration[5.1]
  def change
    add_column :specifications, :deleted_at, :datetime
    add_index :specifications, :deleted_at
  end
end
