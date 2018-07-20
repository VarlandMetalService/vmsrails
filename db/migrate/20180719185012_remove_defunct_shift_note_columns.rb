class RemoveDefunctShiftNoteColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :shift_notes, :response
    remove_column :shift_notes, :response_uid
    remove_column :shift_notes, :attachment
  end
end
