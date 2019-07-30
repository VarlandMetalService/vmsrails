require 'json'

class Opto::Log < ApplicationRecord

  # Pagination.
  paginates_per 100

  # Scoping.
  scope :with_timestamp_gte, ->(timestamp) { where("controller_timestamp >= ?", timestamp) unless timestamp.nil? }
  scope :with_timestamp_lte, ->(timestamp) { where("controller_timestamp <= ?", timestamp) unless timestamp.nil? }
  scope :with_controller, ->(controller) { where("controller_id = ?", controller) unless controller.nil? }
  scope :with_type, ->(type) { where("type = ?", type) unless type.nil? }
  scope :sorted_by, ->(sort) {
    case sort
    when 'controller'
      sort_by = 'opto_controllers.name, controller_timestamp DESC'
    when 'type'
      sort_by = 'type, controller_timestamp DESC'
    when 'controller_and_type'
      sort_by = 'opto_controllers.name, type, controller_timestamp DESC'
    when 'oldest'
      sort_by = 'controller_timestamp'
    else
      sort_by = 'controller_timestamp DESC'
    end
    joins(:controller).order(sort_by)
  }

  # Associations.
  belongs_to :controller

  # Instance methods.

  def parse_controller_timestamp(raw)
    timestamp = ::DateTime.strptime(raw, "%m/%d/%Y %H:%M:%S")
    self.controller_timestamp = Time.zone.parse(timestamp.to_s)
  end

  def log_type
    vms_substitutions = [
      {replace: "Ro", with: "RO"},
      {replace: "Kwh", with: "KWH"}
    ]
    temp = self.type.demodulize.titleize
    vms_substitutions.each do |sub|
      if temp.include? sub[:replace]
        temp[sub[:replace]] = sub[:with]
      end
    end
    return temp
  end

  def details
    "Method must be overridden in child classes!"
  end

  def sms
    ::ActionView::Base.full_sanitizer.sanitize(self.details)
  end

  def opto_data
    json = ::ActiveSupport::JSON.decode(self.json_data)
    return json.symbolize_keys
  end
end
