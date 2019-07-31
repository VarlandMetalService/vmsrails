require 'json'

class Opto::OvenDoorOpenWhileRunning < Opto::Log

  # Instance methods.

  def details
    "Oven door opened for too long while running. Oven: <strong><code>#{self.oven}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Oven Door Open While Running",
      recipients: ["toby.varland@varland.com"]
    }
  end

end