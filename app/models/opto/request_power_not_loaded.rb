require 'json'

class Opto::RequestPowerNotLoaded < Opto::Log

  # Instance methods.

  def details
    "Oven requesting power while not loaded. Oven: <strong><code>#{self.oven}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Oven Requesting Power While Not Loaded",
      recipients: ["toby.varland@varland.com"]
    }
  end

end