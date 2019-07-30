require 'json'

class Opto::OvenNotRequestingPower < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).oven_not_requesting_power.deliver
  end

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Oven not requesting power during warmup. Oven may not be turned on. Oven: <strong><code>#{details["oven"]}#{details["side"]}</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::OvenNotRequestingPower.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end