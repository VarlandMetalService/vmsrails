require 'json'

class Opto::DichromateTemperatureHigh < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_temperature_high.deliver
  end

  def details
    "Dichromate tank temperature is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateTemperatureHigh.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.reading = log_details[:reading].to_f
    new_log.limit = log_details[:limit].to_f
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end