class MaintenanceController < ApplicationController

  skip_before_action  :authenticate_user

  has_scope :sorted_by,
            only: :scheduled_task_status,
            default: 'due',
            allow_blank: true
  has_scope :due_in_next_x_days,
            only: :scheduled_task_status,
            default: 7,
            allow_blank: true
  has_scope :with_task,
            only: :scheduled_task_status
  has_scope :with_type,
            only: :scheduled_task_status
  has_scope :with_equipment,
            only: :scheduled_task_status

  def scheduled_task_status
    @scheduled_task_statuses = apply_scopes(Maintenance::ScheduledTaskStatus).all
  end

end
