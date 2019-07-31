require 'json'

class Opto::DichromateReclaimSumpSolutionHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Reclaim Sump Solution Level Low",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate reclaim sump solution level is high."
  end

end