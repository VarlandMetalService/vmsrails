class CreateMaintenanceScheduledTaskStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :maintenance_scheduled_task_statuses do |t|
      t.string :equipment_type_name
      t.string :equipment_name
      t.string :task_name
      t.string :equipment_type_description
      t.string :equipment_serial_number
      t.string :equipment_description_1
      t.string :equipment_description_2
      t.string :equipment_description_3
      t.string :equipment_description_4
      t.string :equipment_manufacturer
      t.string :equipment_model
      t.date :equipment_in_service_date
      t.string :equipment_department
      t.string :equipment_location
      t.string :task_description
      t.string :task_url
      t.integer :scheduled_task_frequency
      t.string :scheduled_task_description
      t.date :last_maintenance_date
      t.string :last_maintenance_initials
      t.string :code_name
      t.string :code_description
    end
  end
end
