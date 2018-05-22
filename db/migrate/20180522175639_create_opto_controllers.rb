class CreateOptoControllers < ActiveRecord::Migration[5.1]
  def change
    create_table :opto_controllers do |t|
      t.string :ip_address
      t.string :name
      t.string :series
      t.integer :department
      t.timestamps
    end
  end
end
