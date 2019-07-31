require 'json'

class Opto::OvenTooHighTooLong < Opto::Log

  # Instance methods.

  def details
    "Bake cycle reset and oven turned off because oven temperature too high for too long. You will have to re-enter loadings. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Too High Too Long",
      recipients: ["toby.varland@varland.com"]
    }
  end

end