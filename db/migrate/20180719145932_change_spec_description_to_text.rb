class ChangeSpecDescriptionToText < ActiveRecord::Migration[5.1]
  def change
    change_column :specifications, :description, :text
    change_column :classifications, :description, :text
  end
end
