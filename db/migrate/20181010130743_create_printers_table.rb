class CreatePrintersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :printers_tables do |t|
      t.string :name
      t.string :command
    end
  end
end
