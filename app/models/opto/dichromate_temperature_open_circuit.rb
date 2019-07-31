require 'json'

class Opto::DichromateTemperatureOpenCircuit < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Tank Temperature Open Circuit",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Open circuit on dichromate tank temperature &ndash; Opto cannot read the temperature. The steam will be disabled and the exhaust will stay on until fixed."
  end

end