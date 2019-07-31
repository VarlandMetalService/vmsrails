require 'json'

class Opto::RoRejectOverflow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Reject Overflow",
      recipients: ["toby.varland@varland.com", "5134768439@vtext.com"]
    }
  end

  def log_type
    "RO Reject Overflow"
  end

  def details
    "RO reject tank is about to overflow."
  end

end