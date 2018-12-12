require 'json'

class Opto::ChillerOffWarning < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).chiller_off_warning.deliver
  end

  def details
    "Chiller not running when expected. Chiller: <strong><code>#{self.opto_data[:chiller]}</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::ChillerOffWarning.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end