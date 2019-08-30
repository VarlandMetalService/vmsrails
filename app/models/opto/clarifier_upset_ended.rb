require 'json'

class Opto::ClarifierUpsetEnded < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Clarifier upset ended."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Clarifier: Upset Ended",
      recipients: [Opto::BRIAN_EMAIL, Opto::TOBY_EMAIL, Opto::BRIAN_CELL, Opto::TOBY_CELL]
    }
  end

end