class CreateOptoLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :opto_logs do |t|
      t.integer :controller_id
      t.string :type
      t.datetime :controller_timestamp
      t.integer :lane
      t.integer :station
      t.integer :shop_order
      t.integer :load
      t.integer :barrel
      t.string :customer
      t.string :process
      t.string :part
      t.string :sub
      t.float :reading
      t.float :limit
      t.text :json_data
      t.timestamps
    end
  end
end
