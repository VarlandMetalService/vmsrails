require 'json'

class Opto::RoStorageTankOverflow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Storage Tank Overflow",
      recipients: [Opto::FOREMAN_EMAIL,
                   Opto::LAB_EMAIL,
                   Opto::RICH_CELL,
                   Opto::CLIFF_CELL,
                   Opto::TED_CELL]
    }
  end

  def log_type
    "RO Storage Tank Overflow"
  end

  def details
    "RO storage tank is about to overflow."
  end

end