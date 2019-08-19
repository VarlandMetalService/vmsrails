require 'json'

class Opto::ThreePhasePowerOff < Opto::Log

  # Instance methods.

  def details
    "3 phase power may be turned off. Current reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} KWH</code></strong>. Warning trigger: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} KWH</code></strong>."
  end

  def log_type
    "3 Phase Power Off"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Energy: 3 Phase Power Off",
      recipients: [Opto::BRIAN_CELL,
                   Opto::CLIFF_CELL,
                   Opto::ROSS_CELL,
                   Opto::TED_CELL,
                   Opto::RICH_CELL,
                   Opto::LAB_EMAIL]
    }
  end

end