class CreateQcRejectedPartsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :qc_rejected_parts do |t|
      t.integer :so_num
      t.integer :user_id
      t.date :date
      t.integer :reject_tag_num
      t.string :from_tag
      t.string :defect
      t.string :loads_approved
      t.integer :approved_by
      t.text :section2_comments
      t.string :load_nums
      t.string :barrel_nums
      t.string :tank_nums
      t.text :cause

      t.timestamps
    end
  end
end
