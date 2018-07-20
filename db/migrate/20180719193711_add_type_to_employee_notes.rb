class AddTypeToEmployeeNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_notes, :note_type, :string
  end
end
