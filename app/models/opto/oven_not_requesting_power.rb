require 'json'

class Opto::OvenNotRequestingPower < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Oven Not Requesting Power During Warmup",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

  def details
    "Oven not requesting power during warmup. Oven may not be turned on. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>."
  end

end