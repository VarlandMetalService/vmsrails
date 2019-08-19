require 'json'

class Opto::RoRejectOverflow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Reject Overflow",
      recipients: [Opto::FOREMAN_EMAIL,
                   Opto::LAB_EMAIL,
                   Opto::RICH_CELL,
                   Opto::CLIFF_CELL,
                   Opto::TED_CELL]
    }
  end

  def log_type
    "RO Reject Overflow"
  end

  def details
    "RO reject tank is about to overflow."
  end

end