class RedesignPrintTables < ActiveRecord::Migration[5.1]
  def change

    create_table :print_queues do |t|
      t.string :printer
      t.string :options
      t.timestamps
    end

    create_table :print_queue_rules do |t|
      t.integer :user_id
      t.integer :workstation_id
      t.integer :document_type_id
      t.integer :print_queue_id
      t.integer :weight
      t.timestamps
    end

    create_table :print_jobs do |t|
      t.integer :user_id
      t.integer :workstation_id
      t.integer :document_type_id
      t.integer :print_queue_id
      t.string  :file
      t.boolean :is_complete
      t.timestamps
    end
  end
end
