class Classification < ApplicationRecord

  # Soft deletes.
  acts_as_paranoid

  # Associations.
  belongs_to  :specification
  
  # Validations.
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name,
                                          scope: :specification_id,
                                          case_sensitive: false,
                                          message: "must be unique within a specification"
  validate :validate_classification
  validates :vms_process_code,
            presence: true
  validates :thickness_unit,
            inclusion: {  in: %w(in µm),
                          message: "%{value} is not a valid thickness unit" },
            allow_blank: true
  validates :bake_temperature_unit,
            inclusion: {  in: ['º F', 'º C'],
                          message: "%{value} is not a valid temperature unit" },
            allow_blank: true

  # Scoping.
  scope :non_default, -> { where.not(name: '') }
  # default_scope { order('name') }

  # Callbacks.

  # Format fields before validation.
  before_validation do

    # Format case-specific fields.
    self.vms_process_code.upcase! unless self.vms_process_code.blank?

  end

  # Methods.
  def validate_classification

    # If either a minimum or maximum thickness given, unit can't be blank.
    unless minimum_thickness.blank? && maximum_thickness.blank?
      if thickness_unit.blank?
        errors.add(:thickness_unit,
                   "must be specified if either minimum or maximum thickness specified")
      end
    end

    # If both minimum and maximum thickness given, max must be greater than min.
    if !minimum_thickness.blank? && !maximum_thickness.blank?
      if minimum_thickness >= maximum_thickness
        errors.add(:minimum_thickness,
                   "must be less than the maximum thickness specified")
      end
    end

    # If both minimum and maximum alloy percentage given, max must be greater than min.
    if !minimum_alloy_percentage.blank? && !maximum_alloy_percentage.blank?
      if minimum_alloy_percentage >= maximum_alloy_percentage
        errors.add(:minimum_alloy_percentage,
                   "must be less than the maximum alloy percentage specified")
      end
    end

    # If bake variation limit given, require temperature.
    if !bake_variation_limit.blank? && bake_setpoint.blank?
      errors.add(:bake_setpoint,
                 "must be specified if the variation limit is specified")
    end

    # If bake setpoint given, require temperature unit.
    if !bake_setpoint.blank? && bake_temperature_unit.blank?
      errors.add(:bake_temperature_unit,
                 "must be specified if bake temperature specified")
    end

  end
  
  def is_default_classification?
    return self.name.blank?
  end

end