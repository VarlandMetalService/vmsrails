class Materials::VatHistoryNote < ApplicationRecord

  # Pagination.
  paginates_per 100

  # Scoping.
  scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
  scope :with_timestamp_gte, ->(timestamp) { where("notes_timestamp >= ?", timestamp) unless timestamp.nil? }
  scope :with_timestamp_lte, ->(timestamp) { where("notes_timestamp <= ?", timestamp) unless timestamp.nil? }
  scope :with_vat, ->(vat) { where("vat_id = ?", vat) unless vat.nil? }
  scope :with_department, ->(department) { joins(:vat).where("materials_vats.department = ?", department) unless department.nil? }
  # scope :with_search_term, ->(term) { where("notes LIKE :search", search: "%#{term}%") unless term.blank? }
  scope :with_search_term, ->(term) {
    unless term.blank?
      search = ApplicationController.helpers.split_search_terms(term)
      conditions = []
      parameters = {}
      term_index = 1
      search[:include].each do |t|
        key = "search#{term_index}"
        conditions << "notes LIKE :#{key}"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      search[:exclude].each do |t|
        key = "search#{term_index}"
        conditions << "notes NOT LIKE :#{key}"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      where(conditions.join(' AND '), parameters.symbolize_keys)
    end
  }
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
  belongs_to :user, class_name: '::User', optional: true

  # Class methods.

  def self.options_for(field)
    case field
    when "sort"
      [['Newest', 'newest'],
       ['Oldest', 'oldest'],
       ['Vat'   , 'vat'   ]]
    when "dept"
      Materials::Vat.pluck(:department).uniq
    when "vat"
      Materials::VatHistoryNote.joins(:vat).distinct.pluck(:code, :description, :vat_id).map { |c, d, i| ["#{c} &ndash; #{d}".html_safe, i]}.uniq
    when "user"
      User.pluck(:first_name, :last_name, :suffix, :id).uniq.map { |f,l,s,i| ["#{f} #{l} #{s}", i]}
    end
  end

end
