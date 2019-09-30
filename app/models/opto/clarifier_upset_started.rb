require 'json'

class Opto::ClarifierUpsetStarted < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Clarifier upset started."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Clarifier: Upset Started",
      recipients: [Opto::FOREMEN_EMAIL, Opto::BRIAN_EMAIL, Opto::TOBY_EMAIL, Opto::RICH_EMAIL, Opto::BRIAN_CELL, Opto::TOBY_CELL, Opto::RICH_CELL]
    }
  end

end