require 'json'

class Opto::OvenWarmupShutdown < Opto::Log

  # Instance methods.

  def log_type
    "Oven Turned Off Because Warmup Took Too Long"
  end

  def details
    "Oven turned off because warmup took too long. Oven: <strong><code>#{self.oven}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Oven Turned Off Because Warmup Took Too Long",
      recipients: [Opto::JOEL_CELL, Opto::RICH_CELL]
    }
  end

end