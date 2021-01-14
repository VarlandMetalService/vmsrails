require 'json'

class Opto::TreatedCyanide < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Waste Water: Treated Cyanide",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Completed cyanide treatment."
  end

end