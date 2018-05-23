require 'json'

class Opto::DichromateReclaimSumpSolutionHigh < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_reclaim_sump_solution_high.deliver
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateReclaimSumpSolutionHigh.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end