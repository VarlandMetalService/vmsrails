require 'json'

class Opto::ChillerOnWarning < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).chiller_on_warning.deliver
  end

  def details
    "Chiller #{self.opto_data[:chiller]} is running while Opto expects it to be off."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::ChillerOnWarning.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end