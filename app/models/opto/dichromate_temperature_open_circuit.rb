require 'json'

class Opto::DichromateTemperatureOpenCircuit < Opto::Log

  # Instance methods.

  def details
    "Open circuit on dichromate tank temperature &ndash; Opto cannot read the temperature. The steam will be disabled and the exhaust will stay on until fixed."
  end

end