class AddAttachmentsToShitNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :shift_notes, :attachment, :string
  end
end
