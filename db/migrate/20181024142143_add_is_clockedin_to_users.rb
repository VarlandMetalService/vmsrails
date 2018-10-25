class AddIsClockedinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_clockedin, :boolean
  end
end
