require 'json'

class Opto::DichromateRinseHoldingSolutionHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Rinse Holding Tank Solution Level High",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate rinse holding tank solution level is high."
  end

end