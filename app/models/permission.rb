class Permission < ApplicationRecord

  # Pagination.
  paginates_per 100

  # Associations.
  has_many      :assigned_permissions,
                -> { includes(:user).order('users.employee_number ASC') }
  has_many      :users,
                -> { select('users.*, assigned_permissions.value AS access_level') },
                :through => :assigned_permissions

  accepts_nested_attributes_for   :assigned_permissions,
                                  reject_if: :all_blank,
                                  allow_destroy: true
  accepts_nested_attributes_for   :users

  # Filters.
  before_save { self.permission = permission.downcase }

  # Validations.
  validates :permission,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :description,
            presence: true
            
end