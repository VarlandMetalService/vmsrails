require 'json'

class Opto::DichromateTemperatureOpenCircuit < Opto::Log

  # Callbacks.
  after_create :process_notification

  # Instance methods.

  def process_notification
    OptoMailer.with(log: self).dichromate_temperature_open_circuit.deliver
  end

  def details
    "Open circuit on dichromate tank temperature &ndash; Opto cannot read the temperature. The steam will be disabled and the exhaust will stay on until fixed."
  end

  # Class methods.

  def self.parse(controller, log_details)
    new_log = Opto::DichromateTemperatureOpenCircuit.new
    new_log.controller = controller
    new_log.parse_controller_timestamp(log_details[:controller_timestamp])
    new_log.json_data = ::ActiveSupport::JSON.encode(log_details)
    return new_log
  end

end