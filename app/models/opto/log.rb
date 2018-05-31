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
    self.controller_timestamp = ::DateTime.strptime(raw, "%m/%d/%Y %H:%M:%S")
  end

  def log_type
    self.type.demodulize.titleize
  end

  def details
    "Method must be overridden in child classes!"
  end

  def sms
    "Method must be overridden in child classes!"
  end

  def opto_data
    json = ::ActiveSupport::JSON.decode(self.json_data)
    return json.symbolize_keys
  end

  # Class methods.

  def self.options_for_sorted_by
    [['Newest', 'newest'],
     ['Oldest', 'oldest'],
     ['Controller', 'controller'],
     ['Type', 'type'],
     ['Controller & Type', 'controller_and_type']]
  end

end