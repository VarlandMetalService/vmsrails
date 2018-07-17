class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string  :permission
      t.string  :description
      t.integer :label_set
    end
    create_table :assigned_permissions do |t|
      t.belongs_to  :permission
      t.belongs_to  :user
      t.integer     :value
      t.timestamps
    end
  end
end
