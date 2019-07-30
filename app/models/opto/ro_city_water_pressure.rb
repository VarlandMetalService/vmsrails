require 'json'

class Opto::RoCityWaterPressure < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).ro_city_water_pressure.deliver
  end

  def details
    "City water pressure dropped in the RO system, so the RO system cannot run."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::RoCityWaterPressure.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end