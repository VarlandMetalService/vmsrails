class CreateMaterialsVats < ActiveRecord::Migration[5.1]
  def change
    create_table :materials_vats do |t|
      t.string :code
      t.string :description
      t.string :account
      t.integer :department
    end
  end
end
