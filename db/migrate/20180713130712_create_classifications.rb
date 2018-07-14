class CreateClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :classifications do |t|
      t.integer :specification_id
      t.string :name
      t.string :description
      t.string :vms_process_code
      t.string :color
      t.float :minimum_alloy_percentage
      t.float :maximum_alloy_percentage
      t.float :minimum_thickness
      t.float :maximum_thickness
      t.string :thickness_unit
      t.integer :salt_spray_white_spec
      t.integer :salt_spray_red_spec
      t.integer :bake_setpoint
      t.integer :bake_variation_limit
      t.string :bake_temperature_unit
      t.integer :bake_soak_length
      t.integer :bake_within_limit
      t.boolean :bake_requires_inert_atmosphere
      t.text :notes
      t.timestamps
    end
  end
end
