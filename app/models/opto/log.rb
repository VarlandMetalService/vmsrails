require 'json'

class Opto::Log < ApplicationRecord

  # Callbacks.
  after_create :process_notification

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

  def notification_settings
    {
      enabled: false,
      subject: nil,
      recipients: nil
    }
  end

  def process_notification
    if self.notification_settings[:enabled]
      OptoMailer.with(log: self).opto_notification.deliver_later
    end
  end

  def parse_controller_timestamp(raw)
    timestamp_parts = raw.split
    date_parts = timestamp_parts[0].split('/')
    time_parts = timestamp_parts[1].split(':')
    date_string = "#{date_parts[1]}.#{date_parts[0]}.#{date_parts[2]} #{time_parts[0]}:#{time_parts[1]}:#{time_parts[2]}"
    self.controller_timestamp = date_string.in_time_zone("Eastern Time (US & Canada)").to_datetime
  end

  def log_type
    self.type.demodulize.titleize
  end

  def details
    self.json_data.to_s
  end

  def sms
    ::ActionView::Base.full_sanitizer.sanitize(self.details.gsub("<br>", "\n").gsub("<br />", "\n"))
  end

  def opto_data
    ::ActiveSupport::JSON.decode(self.json_data).symbolize_keys
  end

# Class methods.

  def self.parse(controller, log_details)
    new_log = self.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp]) if log_details.key?(:controller_timestamp)
    new_log.limit = log_details.fetch(:limit, nil)
    new_log.reading = log_details.fetch(:reading, nil)
    new_log.lane = log_details.fetch(:lane, nil)
    new_log.station = log_details.fetch(:station, nil)
    new_log.shop_order = log_details.fetch(:shop_order, nil)
    new_log.load = log_details.fetch(:load, nil)
    new_log.barrel = log_details.fetch(:barrel, nil)
    new_log.customer = log_details.fetch(:customer, nil)
    new_log.process = log_details.fetch(:process, nil)
    new_log.part = log_details.fetch(:part, nil)
    new_log.sub = log_details.fetch(:sub, nil)
    new_log.oven = log_details.fetch(:oven, nil)
    new_log.side = log_details.fetch(:side, nil)
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end
