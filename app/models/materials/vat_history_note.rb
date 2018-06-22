class Materials::VatHistoryNote < ApplicationRecord

  # Pagination.
  paginates_per 100

  # Scoping.
  scope :with_timestamp_gte, ->(timestamp) { where("notes_timestamp >= ?", timestamp) unless timestamp.nil? }
  scope :with_timestamp_lte, ->(timestamp) { where("notes_timestamp <= ?", timestamp) unless timestamp.nil? }
  scope :with_vat, ->(vat) { where("vat_id = ?", vat) unless vat.nil? }
  scope :with_department, ->(department) { joins(:vat).where("materials_vats.department = ?", department) unless department.nil? }
  scope :with_search_term, ->(term) { where("notes LIKE :search", search: "%#{term}%") unless term.blank? }
  scope :sorted_by, ->(sort) {
    case sort
    when 'vat'
      sort_by = 'materials_vats.code, notes_timestamp DESC'
    when 'oldest'
      sort_by = 'notes_timestamp'
    else
      sort_by = 'notes_timestamp DESC'
    end
    joins(:vat).order(sort_by)
  }

  # Associations.
  belongs_to :vat

  # Class methods.

  def self.options_for_sorted_by
    [['Newest', 'newest'],
     ['Oldest', 'oldest'],
     ['Vat', 'vat']]
  end

end
