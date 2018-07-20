class CreateEmployeeNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_notes do |t|
      t.integer :employee
      t.integer :entered_by
      t.date :note_on
      t.string :ip_address
      t.text :notes
      t.text :follow_up
      t.date :follow_up_on
      t.datetime :deleted_at
      t.index :deleted_at
      t.timestamps
    end
  end
end
