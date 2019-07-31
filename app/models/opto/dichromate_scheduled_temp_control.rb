require 'json'

class Opto::DichromateScheduledTempControl < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Turned On Dichromate Temp Control",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Turned on temperature control at scheduled time: <strong><code>#{details["scheduled_time"]}</code></strong>."
  end

end