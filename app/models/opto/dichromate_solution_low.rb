require 'json'

class Opto::DichromateSolutionLow < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_solution_low.deliver
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateSolutionLow.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.reading = log_details[:reading].to_f
    new_log.limit = log_details[:limit].to_f
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end