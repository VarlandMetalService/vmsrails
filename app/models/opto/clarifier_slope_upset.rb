require 'json'

class Opto::ClarifierSlopeUpset < Opto::Log

  # Instance methods.

  def details
    "Clarifier slope upset started. Limit: #{self.limit.to_f.round(2)}. Reading: #{self.reading.to_f.round(2)}."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Clarifier: Slope Upset",
      recipients: [Opto::FOREMEN_EMAIL, Opto::BRIAN_EMAIL, Opto::RICH_EMAIL, Opto::BRIAN_CELL, Opto::RICH_CELL]
    }
  end

end