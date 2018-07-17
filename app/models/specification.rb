class Specification < ApplicationRecord

  # Soft deletes.
  acts_as_paranoid

  # Pagination.
  paginates_per 100

  # File uploaders.
  mount_uploader :file, SpecificationUploader

  # Associations.
  has_many  :classifications,
            inverse_of: :specification
  accepts_nested_attributes_for :classifications,
                                reject_if: :all_blank,
                                allow_destroy: true
  
  # Validations.
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name,
                                          scope: [:organization, :revision],
                                          case_sensitive: false,
                                          message: "must be unique within an organization"
  validates :organization,
            presence: true
  validates :name,
            presence: true
  validates :description,
            presence: true

  # Scoping.
  default_scope { order('specifications.organization, specifications.name') }
  # scope :with_archived, -> { unscope(where: :archived_at) }
  scope :without_archived, -> { where(archived_at: nil) }
  scope :archived, -> { unscope(where: :archived_at).where.not(archived_at: nil) }
  scope :with_organization, ->(organization) { where("specifications.organization = ?", organization) unless organization.nil? }
  scope :with_name, ->(name) { where("specifications.name = ?", name) unless name.nil? }
  scope :with_classification, ->(classification) { joins(:classifications).where("classifications.name = ?", classification).distinct() unless classification.nil? }
  scope :with_process_code, ->(process_code) { joins(:classifications).where("classifications.vms_process_code = ?", process_code).distinct() unless process_code.nil? }
  scope :with_color, ->(color) { joins(:classifications).where("classifications.color = ?", color).distinct() unless color.nil? }
  scope :with_search_term, ->(term) {
    unless term.blank?
      search = ApplicationController.helpers.split_search_terms(term)
      conditions = []
      parameters = {}
      term_index = 1
      search[:include].each do |t|
        key = "search#{term_index}"
        sub_conditions = []
        sub_conditions << "specifications.organization LIKE :#{key}"
        sub_conditions << "specifications.name LIKE :#{key}"
        sub_conditions << "specifications.description LIKE :#{key}"
        sub_conditions << "classifications.name LIKE :#{key}"
        sub_conditions << "classifications.description LIKE :#{key}"
        sub_conditions << "classifications.notes LIKE :#{key}"
        sub_conditions << "classifications.vms_process_code LIKE :#{key}"
        sub_conditions << "classifications.color LIKE :#{key}"
        conditions << "(#{sub_conditions.join(' OR ')})"
        parameters[key] = "%#{t}%"
        term_index += 1
      end
      left_outer_joins(:classifications).where(conditions.join(' AND '), parameters.symbolize_keys).distinct()
    end
  }

  # Methods.
  def default_classification
    self.classifications.find_by_name(['', nil])
  end

end