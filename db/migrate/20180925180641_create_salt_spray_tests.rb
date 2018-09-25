class CreateSaltSprayTests < ActiveRecord::Migration[5.1]
  def change
    create_table :salt_spray_tests do |t|
      t.integer :so_num
      t.integer :load_num
      t.string :customer
      t.string :process_code
      t.string :part_num
      t.string :sub
      t.decimal :part_area
      t.decimal :density
      t.integer :white_spec
      t.integer :red_spec
      t.string :dept
      t.decimal :load_weight
      t.integer :on_by
      t.datetime :on_at
      t.integer :off_by
      t.datetime :off_at
      t.integer :white_by
      t.datetime :white_at
      t.integer :red_by
      t.datetime :red_at
      t.integer :flagged_by
    end
  end
end
