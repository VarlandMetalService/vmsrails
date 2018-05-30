require 'json'

class Opto::DichromateScheduledTempControl < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_scheduled_temp_control.deliver
  end

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Turned on temperature control at scheduled time: <strong><code>#{details["scheduled_time"]}</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateNoTempControl.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end