class CreateClockRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :clock_records do |t|

      t.timestamps
      t.integer  :user_id
      t.string   :record_type
      t.string   :ip_address
      t.datetime :timestamp
      t.datetime :deleted_at
    end
  end
end
