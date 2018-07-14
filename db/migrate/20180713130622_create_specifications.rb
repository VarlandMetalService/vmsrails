class CreateSpecifications < ActiveRecord::Migration[5.1]
  def change
    create_table :specifications do |t|
      t.string :organization
      t.string :name
      t.string :description
      t.string :revision
      t.string :file
      t.timestamps
    end
  end
end
