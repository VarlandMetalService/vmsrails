require 'json'

class Opto::BadOvenProbe < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).bad_oven_probe.deliver
  end

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    probes = []
    details["probes"].each_with_index do |name, index|
      probes << "Probe Name: <strong><code>#{name}</code></strong>, Reading: <strong><code>#{details["readings"][index]}</code></strong>"
    end
    "Suspected bad temperature probe.<br />#{probes.join("<br />")}"
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::BadOvenProbe.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end