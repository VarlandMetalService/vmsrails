require 'json'

class Opto::DichromateTemperatureControlDisabled < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Temp Control Disabled",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Opto automatically turned off temperature control due to inactivity. Timeout: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} seconds</code></strong>."
  end

end