require 'json'

class Opto::OvenFinishedBaking < Opto::Log

  # Instance methods.

  def details
    "Oven finished baking. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Finished Baking",
      recipients: ["toby.varland@varland.com"]
    }
  end

end