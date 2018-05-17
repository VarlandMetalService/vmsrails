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
  scope :with_task, ->(task) { where("scheduled_task_description = :search", search: task) unless task.blank? }
  scope :with_type, ->(type) { where("equipment_type_name = :search", search: type) unless type.blank? }
  scope :with_equipment, ->(name) { where("equipment_name = :search", search: name) unless name.blank? }

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