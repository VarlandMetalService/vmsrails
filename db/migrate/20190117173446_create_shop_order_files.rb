class CreateShopOrderFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_order_files do |t|
      t.string :file
      t.integer :so_num

      t.timestamps
    end
  end
end
