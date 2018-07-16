class AddDeletedAtToClassifications < ActiveRecord::Migration[5.1]
  def change
    add_column :classifications, :deleted_at, :datetime
    add_index :classifications, :deleted_at
  end
end
