class DeptInfo::Document < ApplicationRecord

  # Scoping.
  default_scope { order('is_starred DESC, updated_at DESC') }
  scope :with_search_term, ->(term) { where("name LIKE :search OR content_type LIKE :search OR description LIKE :search OR contents LIKE :search", search: "%#{term}%") unless term.blank? }
  scope :changed_after, ->(after_date) { where("DATE(updated_at) >= ?", after_date) unless after_date.blank? }
  scope :changed_before, ->(before_date) { where("DATE(updated_at) <= ?", before_date) unless before_date.blank? }

  # Associations.
  belongs_to :folder

  # Validation.
  validates :name,
            presence: true,
            uniqueness: { scope: :folder_id,
                          message: "must be unique within a folder" }
  
  # Document folder path.
  def folder_path
    return '' if self.folder.nil?
    folders = []
    folders << self.folder.name
    f = self.folder
    until f.parent.nil?
      folders << f.parent.name
      f = f.parent
    end
    return folders.reverse.join ' &rarr; '
  end

  # Returns age in days.
  def age
    return ((Time.now - self.updated_at).to_i / 86400).to_i
  end

end
