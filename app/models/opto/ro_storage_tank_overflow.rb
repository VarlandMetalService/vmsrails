require 'json'

class Opto::RoStorageTankOverflow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Storage Tank Overflow",
      recipients: ["toby.varland@varland.com", "5134768439@vtext.com"]
    }
  end

  def log_type
    "RO Storage Tank Overflow"
  end

  def details
    "RO storage tank is about to overflow."
  end

end