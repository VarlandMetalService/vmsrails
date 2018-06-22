class CreateMaterialsVatHistoryNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :materials_vat_history_notes do |t|
      t.integer :vat_id
      t.datetime :notes_timestamp
      t.text :notes
    end
  end
end
