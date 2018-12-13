class CreateWorkstationGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :workstation_groups do |t|
      t.string :name
      t.string :description
    end

    create_table :workstation_groups_workstations, id: false do |t|
      t.belongs_to :workstation, index: true, foreign_key: true
      t.belongs_to :workstation_group, index: true, foreign_key: true
    end

    rename_column :print_queue_rules, :workstation_id, :workstation_group_id
    remove_column   :print_queue_rules, :weight
  end
end
