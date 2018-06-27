class AddUserToVatHistoryNotes < ActiveRecord::Migration[5.1]
  def change
    change_table :materials_vat_history_notes do |t|
      t.integer :user_id
    end
  end
end
