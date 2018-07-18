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
  scope :with_classification, ->(classification) { left_outer_joins(:classifications).where("classifications.name = ?", classification).distinct() unless classification.nil? }
  scope :with_process_code, ->(process_code) { left_outer_joins(:classifications).where("classifications.vms_process_code = ?", process_code).distinct() unless process_code.nil? }
  scope :with_color, ->(color) { left_outer_joins(:classifications).where("classifications.color = ?", color).distinct() unless color.nil? }
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
        sub_conditions << "specifications.notes LIKE :#{key}"
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
  scope :with_inert_bake, ->(term) {
    unless term.blank?
      value = 'FALSE'
      case term
      when 'Yes'
        value = 'TRUE'
      end
      left_outer_joins(:classifications).where("(classifications.bake_setpoint IS NOT NULL AND classifications.bake_requires_inert_atmosphere IS #{value})").distinct()
    end
  }
  scope :with_ss_white_spec, ->(term) {
    with_numeric_term(term, 'classifications.salt_spray_white_spec')
  }
  scope :with_ss_red_spec, ->(term) {
    with_numeric_term(term, 'classifications.salt_spray_red_spec')
  }
  scope :with_min_alloy_percentage, ->(term) {
    with_numeric_term(term, 'classifications.minimum_alloy_percentage')
  }
  scope :with_max_alloy_percentage, ->(term) {
    with_numeric_term(term, 'classifications.maximum_alloy_percentage')
  }
  scope :with_min_thickness, ->(term) {
    with_thickness_term(term, 'classifications.minimum_thickness')
  }
  scope :with_max_thickness, ->(term) {
    with_thickness_term(term, 'classifications.maximum_thickness')
  }
  scope :with_bake_temperature, ->(term) {
    with_temperature_term(term, 'classifications.bake_setpoint')
  }
  scope :with_bake_variation_limit, ->(term) {
    with_temp_variation_term(term, 'classifications.bake_variation_limit')
  }
  scope :with_bake_time, ->(term) {
    with_numeric_term(term, 'classifications.bake_soak_length')
  }
  scope :with_bake_within_limit, ->(term) {
    with_numeric_term(term, 'classifications.bake_within_limit')
  }
  scope :with_numeric_term, ->(term, field) {
    unless term.blank?
      search = ApplicationController.helpers.split_numeric_terms(term)
      if search.nil?
        where('1 = 0')
      else
        search[:field] = field
        with_numeric(search)
      end
    end
  }
  scope :with_numeric, ->(search) {
    condition = nil
    case search[:function]
    when 'gte'
      condition = "#{search[:field]} >= #{search[:value]}"
    when 'gt'
      condition = "#{search[:field]} > #{search[:value]}"
    when 'lte'
      condition = "#{search[:field]} <= #{search[:value]}"
    when 'lt'
      condition = "#{search[:field]} < #{search[:value]}"
    when 'eq'
      condition = "#{search[:field]} = #{search[:value]}"
    when 'ne'
      condition = "#{search[:field]} != #{search[:value]}"
    when 'range'
      condition = "(#{search[:field]} >= #{search[:minimum]} AND #{search[:field]} <= #{search[:maximum]})"
    end
    left_outer_joins(:classifications).where(condition).distinct()
  }
  scope :with_thickness_term, ->(term, field) {
    unless term.blank?
      search = ApplicationController.helpers.split_numeric_terms(term)
      if search.nil?
        where('1 = 0')
      else
        search[:field] = field
        with_thickness(search)
      end
    end
  }
  scope :with_thickness, ->(search) {
    conditions = []
    fudge_factor = 0.1
    fudge_up = 1 + fudge_factor
    fudge_down = 1 - fudge_factor
    case search[:function]
    when 'gte'
      microns = ApplicationController.helpers.inches_to_half_micron(search[:value])
      conditions << "(#{search[:field]} >= #{search[:value]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} >= #{microns * fudge_down} AND classifications.thickness_unit = 'µm')"
    when 'gt'
      microns = ApplicationController.helpers.inches_to_half_micron(search[:value])
      conditions << "(#{search[:field]} > #{search[:value]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} > #{microns * fudge_down} AND classifications.thickness_unit = 'µm')"
    when 'lte'
      microns = ApplicationController.helpers.inches_to_half_micron(search[:value])
      conditions << "(#{search[:field]} <= #{search[:value]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} <= #{microns * fudge_up} AND classifications.thickness_unit = 'µm')"
    when 'lt'
      microns = ApplicationController.helpers.inches_to_half_micron(search[:value])
      conditions << "(#{search[:field]} < #{search[:value]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} < #{microns * fudge_up} AND classifications.thickness_unit = 'µm')"
    when 'eq'
      minimum_microns = ApplicationController.helpers.inches_to_half_micron(search[:value]) * fudge_down
      maximum_microns = ApplicationController.helpers.inches_to_half_micron(search[:value]) * fudge_up
      conditions << "(#{search[:field]} = #{search[:value]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} >= #{minimum_microns} AND #{search[:field]} <= #{maximum_microns} AND classifications.thickness_unit = 'µm')"
    when 'ne'
      minimum_microns = ApplicationController.helpers.inches_to_half_micron(search[:value]) * fudge_down
      maximum_microns = ApplicationController.helpers.inches_to_half_micron(search[:value]) * fudge_up
      conditions << "(#{search[:field]} != #{search[:value]} AND classifications.thickness_unit = 'in'"
      conditions << "((#{search[:field]} < #{minimum_microns} OR #{search[:field]} > #{maximum_microns}) AND classifications.thickness_unit = 'µm')"
    when 'range'
      minimum_microns = ApplicationController.helpers.inches_to_half_micron(search[:minimum]) * fudge_down
      maximum_microns = ApplicationController.helpers.inches_to_half_micron(search[:maximum]) * fudge_up
      conditions << "(#{search[:field]} >= #{search[:minimum]} AND #{search[:field]} <= #{search[:maximum]} AND classifications.thickness_unit = 'in')"
      conditions << "(#{search[:field]} >= #{minimum_microns} AND #{search[:field]} <= #{maximum_microns} AND classifications.thickness_unit = 'µm')"
    end
    left_outer_joins(:classifications).where("(#{conditions.join(' OR ')})").distinct()
  }
  scope :with_temperature_term, ->(term, field) {
    unless term.blank?
      search = ApplicationController.helpers.split_numeric_terms(term)
      if search.nil?
        where('1 = 0')
      else
        search[:field] = field
        with_temperature(search)
      end
    end
  }
  scope :with_temperature, ->(search) {
    conditions = []
    fudge_factor = 0.05
    fudge_up = 1 + fudge_factor
    fudge_down = 1 - fudge_factor
    case search[:function]
    when 'gte'
      degF = ((search[:value].to_f - 32) / 1.8)
      conditions << "(#{search[:field]} >= #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{degF * fudge_down} AND classifications.bake_temperature_unit = 'º C')"
    when 'gt'
      degF = ((search[:value].to_f - 32) / 1.8)
      conditions << "(#{search[:field]} > #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} > #{degF * fudge_down} AND classifications.bake_temperature_unit = 'º C')"
    when 'lte'
      degF = ((search[:value].to_f - 32) / 1.8)
      conditions << "(#{search[:field]} <= #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} <= #{degF * fudge_up} AND classifications.bake_temperature_unit = 'º C')"
    when 'lt'
      degF = ((search[:value].to_f - 32) / 1.8)
      conditions << "(#{search[:field]} < #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} < #{degF * fudge_up} AND classifications.bake_temperature_unit = 'º C')"
    when 'eq'
      minimum_degF = ((search[:value].to_f - 32) / 1.8) * fudge_down
      maximum_degF = ((search[:value].to_f - 32) / 1.8) * fudge_up
      conditions << "(#{search[:field]} = #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{minimum_degF} AND #{search[:field]} <= #{maximum_degF} AND classifications.bake_temperature_unit = 'º C')"
    when 'ne'
      minimum_degF = ((search[:value].to_f - 32) / 1.8) * fudge_down
      maximum_degF = ((search[:value].to_f - 32) / 1.8) * fudge_up
      conditions << "(#{search[:field]} != #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "((#{search[:field]} < #{minimum_degF} OR #{search[:field]} > #{maximum_degF}) AND classifications.bake_temperature_unit = 'º C')"
    when 'range'
      minimum_degF = (search[:minimum].to_f - 32) * 5 / 9 * fudge_down
      maximum_degF = (search[:maximum].to_f - 32) * 5 / 9 * fudge_up
      conditions << "(#{search[:field]} >= #{search[:minimum]} AND #{search[:field]} <= #{search[:maximum]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{minimum_degF} AND #{search[:field]} <= #{maximum_degF} AND classifications.bake_temperature_unit = 'º C')"
    end
    left_outer_joins(:classifications).where("(#{conditions.join(' OR ')})").distinct()
  }
  scope :with_temp_variation_term, ->(term, field) {
    unless term.blank?
      search = ApplicationController.helpers.split_numeric_terms(term)
      if search.nil?
        where('1 = 0')
      else
        search[:field] = field
        with_temp_variation(search)
      end
    end
  }
  scope :with_temp_variation, ->(search) {
    conditions = []
    fudge_factor = 0.1
    fudge_up = 1 + fudge_factor
    fudge_down = 1 - fudge_factor
    case search[:function]
    when 'gte'
      degF = ((search[:value].to_f) / 1.8)
      conditions << "(#{search[:field]} >= #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{degF * fudge_down} AND classifications.bake_temperature_unit = 'º C')"
    when 'gt'
      degF = ((search[:value].to_f) / 1.8)
      conditions << "(#{search[:field]} > #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} > #{degF * fudge_down} AND classifications.bake_temperature_unit = 'º C')"
    when 'lte'
      degF = ((search[:value].to_f) / 1.8)
      conditions << "(#{search[:field]} <= #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} <= #{degF * fudge_up} AND classifications.bake_temperature_unit = 'º C')"
    when 'lt'
      degF = ((search[:value].to_f) / 1.8)
      conditions << "(#{search[:field]} < #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} < #{degF * fudge_up} AND classifications.bake_temperature_unit = 'º C')"
    when 'eq'
      minimum_degF = ((search[:value].to_f) / 1.8) * fudge_down
      maximum_degF = ((search[:value].to_f) / 1.8) * fudge_up
      conditions << "(#{search[:field]} = #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{minimum_degF} AND #{search[:field]} <= #{maximum_degF} AND classifications.bake_temperature_unit = 'º C')"
    when 'ne'
      minimum_degF = ((search[:value].to_f) / 1.8) * fudge_down
      maximum_degF = ((search[:value].to_f) / 1.8) * fudge_up
      conditions << "(#{search[:field]} != #{search[:value]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "((#{search[:field]} < #{minimum_degF} OR #{search[:field]} > #{maximum_degF}) AND classifications.bake_temperature_unit = 'º C')"
    when 'range'
      minimum_degF = (search[:minimum].to_f) * 5 / 9 * fudge_down
      maximum_degF = (search[:maximum].to_f) * 5 / 9 * fudge_up
      conditions << "(#{search[:field]} >= #{search[:minimum]} AND #{search[:field]} <= #{search[:maximum]} AND classifications.bake_temperature_unit = 'º F')"
      conditions << "(#{search[:field]} >= #{minimum_degF} AND #{search[:field]} <= #{maximum_degF} AND classifications.bake_temperature_unit = 'º C')"
    end
    left_outer_joins(:classifications).where("(#{conditions.join(' OR ')})").distinct()
  }

  # Methods.
  def default_classification
    self.classifications.find_by_name(['', nil])
  end
  def title
    parts = []
    parts << self.organization
    parts << self.name
    unless self.revision.blank?
      parts << "(Rev: #{self.revision})"
    end
    parts.join ' '
  end

end