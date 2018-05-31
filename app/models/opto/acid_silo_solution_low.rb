require 'json'

class Opto::AcidSiloSolutionLow < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).acid_silo_solution_low.deliver
  end

  def details
    "Acid silo solution level is low. Silo: <strong><code>#{self.opto_data[:silo]}</code></strong>. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} gallons</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} gallons</code></strong>."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::AcidSiloSolutionLow.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.reading = log_details[:reading].to_f
    new_log.limit = log_details[:limit].to_f
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end