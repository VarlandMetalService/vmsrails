class Maintenance::ScheduledTaskStatus < ApplicationRecord

  scope :past_due, -> { where('last_maintenance_date IS NULL OR DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY) < DATE(NOW())') }
  scope :due_in_next_x_days, ->(days) { where("last_maintenance_date IS NULL OR DATE_ADD(last_maintenance_date, INTERVAL scheduled_task_frequency + 0 DAY) <= DATE_ADD(DATE(NOW()), INTERVAL #{days.to_i} DAY)") }

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

end