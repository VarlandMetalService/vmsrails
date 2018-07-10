class CreateShiftNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :shift_notes do |t|
      t.integer :shift_time
      t.integer :user_id
      t.string :dept
      t.string :shift_type
      t.text :message
      t.text :response
      t.integer :response_uid
      t.timestamps
    end
  end
end
