class Maintenance::ScheduledTaskStatus < ApplicationRecord

  # Scoping.
  scope :past_due, -> { where('last_maintenance_date IS NULL OR DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY) < DATE(NOW())') }
  scope :due_in_next_x_days, ->(days) {
    if days.blank?
      where("last_maintenance_date IS NULL OR DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY) <= DATE_ADD(DATE(NOW()), INTERVAL 7 DAY)")
    else
      where("last_maintenance_date IS NULL OR DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY) <= DATE_ADD(DATE(NOW()), INTERVAL #{days.to_i} DAY)")
    end
  }
  scope :soonest_first, -> { order('DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY)') }
  scope :sorted_by, ->(sort) {
    case sort
    when 'task'
      sort = 'scheduled_task_description'
    when 'type'
      sort = 'equipment_type_name'
    when 'equipment'
      sort = 'equipment_name'
    when 'due'
      sort = 'DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY)'
    else
      sort = 'DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY)'
    end
    order(sort)
  }
  scope :with_task, ->(task) {
    return if task.blank?
    sort = 'DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY), equipment_type_name, equipment_name'
    where("scheduled_task_description = :search", search: task).order(sort)
  }
  scope :with_type, ->(type) {
    return if type.blank?
    sort = 'equipment_name, DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY), scheduled_task_description'
    where("equipment_type_name = :search", search: type).order(sort)
  }
  scope :with_equipment, ->(name) {
    return if name.blank?
    sort = 'DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY), scheduled_task_description'
    parts = name.split '__'
    if parts.size == 2
      where("equipment_type_name = :type AND equipment_name = :name", type: parts[0], name: parts[1]).order(sort)
    else
      where("equipment_name = :name", name: name).order(sort)
    end
  }

  def due_date
    return Date.yesterday if self.equipment_in_service_date.nil? && self.last_maintenance_date.nil?
    unless self.last_maintenance_date.nil?
      return self.last_maintenance_date.advance(days: self.scheduled_task_frequency)
    end
    return self.equipment_in_service_date.advance(days: self.scheduled_task_frequency)
  end

  def days_until_due
    due = self.due_date
    return -1 if due.nil?
    return (due - Date.today).to_i
  end

  def past_due?
    return self.days_until_due < 0
  end

  # Class methods.

  def self.options_for_sorted_by
    [['Due Soonest', 'due'],
     ['Scheduled Task Name', 'task'],
     ['Equipment Type', 'type'],
     ['Equipment Name', 'equipment']]
  end

end