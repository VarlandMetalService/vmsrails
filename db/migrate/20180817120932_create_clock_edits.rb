class CreateClockEdits < ActiveRecord::Migration[5.1]
  def change
    create_table :clock_edits do |t|
      t.integer :clock_record_id
      t.integer :user_id
      t.string :ip_address
      t.integer :reason_id
      t.datetime :deleted_at
      t.text :note

      t.timestamps
    end
  end
end
