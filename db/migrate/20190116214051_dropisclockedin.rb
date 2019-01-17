class Dropisclockedin < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_clockedin
  end
end
