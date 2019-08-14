require 'json'

class Opto::OvenLoadingsTimeout < Opto::Log

  # Instance methods.

  def details
    "Oven timed out while still adding parts. Oven will no longer hold temperature down. Oven: <strong><code>#{self.oven}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Loadings Timeout",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

end