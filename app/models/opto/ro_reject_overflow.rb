require 'json'

class Opto::RoRejectOverflow < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).ro_reject_overflow.deliver
  end

  def details
    "RO reject tank is about to overflow."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::RoRejectOverflow.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end