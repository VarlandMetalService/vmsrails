class AddNotesToSpecifications < ActiveRecord::Migration[5.1]
  def change
    add_column :specifications, :notes, :text
  end
end
