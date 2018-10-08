class CreateSaltSprayTestsAndSaltSprayTestChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :salt_spray_tests do |t|
      t.integer  :so_num
      t.integer  :load_num
      t.integer  :user_id
      t.string   :process_code
      t.text     :process
      t.integer  :load_weight

      t.string   :customer
      t.string   :dept
      t.string   :part_tag
      t.string   :sub_tag
      t.string   :part_area
      t.string   :part_density
      t.integer  :white_spec
      t.integer  :red_spec

      t.timestamps
    end

    create_table :salt_spray_test_checks do |t|
      t.string   :type
      t.datetime :date
      t.integer  :user_id
      t.integer  :test_id
      t.timestamps
    end
  end
end
