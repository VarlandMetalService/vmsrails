class AddAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.integer :zip_code
      t.string :phone_number, limit: 10
    end
  end
end
