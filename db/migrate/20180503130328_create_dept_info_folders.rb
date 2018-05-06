class CreateDeptInfoFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :dept_info_folders do |t|
      t.string :name, null: false
      t.bigint :parent_id
      t.bigint :lft
      t.bigint :rgt
      t.integer :depth
      t.string :google_id
      t.timestamps
    end
  end
end
