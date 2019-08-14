require 'json'

class Opto::OvenRequestingPowerTooHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Oven Requesting Power While Too Hot",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

  def details
    "Oven is requesting power while too hot. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>."
  end

end