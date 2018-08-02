class CreateThicknessTables < ActiveRecord::Migration[5.1]
  def change
    create_table  :thickness_blocks do |t|
      t.integer   :user_id
      t.integer   :so_num
      t.integer   :load_num
      t.integer   :block_num
      t.boolean   :is_rework
      t.string    :directory
      t.string    :product 
      t.string    :application
      t.string    :customer
      t.string    :process
      t.string    :part 
      t.string    :sub
      t.float     :load_weight
      t.float     :piece_weight
      t.float     :part_area
      t.float     :part_density
      t.datetime  :deleted_at
    end
    create_table  :thickness_checks do |t|
      t.integer   :block_id
      t.datetime  :check_timestamp
      t.integer   :check_number
      t.float     :thickness_blocks
      t.float     :alloy_percentage
      t.float     :x
      t.float     :y 
      t.float     :z
      t.datetime  :deleted_at
    end
  end
end
