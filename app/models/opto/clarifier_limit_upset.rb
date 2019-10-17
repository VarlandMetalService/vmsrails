require 'json'

class Opto::ClarifierLimitUpset < Opto::Log

  # Instance methods.

  def details
    "Clarifier limit upset started. Limit: #{self.limit.to_f.round(2)}. Reading: #{self.reading.to_f.round(2)}."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Clarifier: Limit Upset",
      recipients: [Opto::FOREMEN_EMAIL, Opto::BRIAN_EMAIL, Opto::TOBY_EMAIL, Opto::RICH_EMAIL, Opto::BRIAN_CELL, Opto::TOBY_CELL, Opto::RICH_CELL]
    }
  end

end