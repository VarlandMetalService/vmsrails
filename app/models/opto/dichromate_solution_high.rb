require 'json'

class Opto::DichromateSolutionHigh < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_solution_high.deliver
  end

  def details
    "Dichromate solution level is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateSolutionHigh.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.reading = log_details[:reading].to_f
    new_log.limit = log_details[:limit].to_f
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end