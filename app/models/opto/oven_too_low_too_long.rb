require 'json'

class Opto::OvenTooLowTooLong < Opto::Log

  # Instance methods.

  def details
    "Bake cycle reset because oven temperature too low for too long. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Too Low Too Long",
      recipients: ["toby.varland@varland.com"]
    }
  end

end