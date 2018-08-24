class CreateTimeclockReasonCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :timeclock_reason_codes do |t|
      t.string :description
      t.boolean :requires_note

      t.timestamps
    end
  end
end
