class EmployeeNote < ApplicationRecord

  # Constants.
  VALID_IP_REGEX = /\A([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}\z/i

  # Soft deletes.
  acts_as_paranoid

  # Pagination.
  paginates_per 100

  # Associations.
  belongs_to    :subject,
                class_name: 'User',
                foreign_key: 'employee'
  belongs_to    :author,
                class_name: 'User',
                foreign_key: 'entered_by'

  # Validations.
  validates :subject,
            presence: true
  validates :entered_by,
            presence: true
  validates :note_on,
            presence: true
  validates :note_type,
            presence: true,
            inclusion: { in: %w(Positive Negative Neutral), message: "%{value} is not a valid type" }
  validates :ip_address,
            presence: true,
            format: { with: VALID_IP_REGEX }
  validates :notes,
            presence: true

  # Scopes.
  scope :sorted_by, ->(sort) {
    case sort
    when 'oldest'
      sort_by = 'note_on, updated_at'
    else
      sort_by = 'note_on DESC, updated_at DESC'
    end
    order(sort_by)
  }
  scope :with_employee, ->(values) {
    where employee: [*values]
  }
  scope :with_note_type, ->(values) {
    where note_type: [*values]
  }
  scope :with_entered_by, ->(values) {
    where entered_by: [*values]
  }
  scope :with_date_gte, ->(value) {
    where 'note_on >= ?', value
  }
  scope :with_date_lte, ->(value) {
    where 'note_on <= ?', value
  }
  scope :with_search_term, ->(term) {
    unless term.blank?
      search = ApplicationController.helpers.split_search_terms(term)
      conditions = []
      parameters = {}
      term_index = 1
      search[:include].each do |t|
        key = "search#{term_index}"
        conditions << "(notes LIKE :#{key} OR follow_up LIKE :#{key})"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      search[:exclude].each do |t|
        key = "search#{term_index}"
        conditions << "(notes NOT LIKE :#{key} AND follow_up NOT LIKE :#{key})"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      where(conditions.join(' AND '), parameters.symbolize_keys)
    end
  }

  # Select options for type.
  def self.options_for_type
    [
      ['Positive', 'Positive'],
      ['Negative', 'Negative'],
      ['Neutral', 'Neutral']
    ]
  end

  # Select options for sorted by.
  def self.options_for_sorted_by
    [
      ['Date (newest first)', 'newest'],
      ['Date (oldest first)', 'oldest']
    ]
  end

end
