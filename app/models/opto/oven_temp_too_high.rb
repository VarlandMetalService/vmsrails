require 'json'

class Opto::OvenTempTooHigh < Opto::Log

  # Instance methods.

  def details
    "Oven temperature high. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Temp High",
      recipients: ["toby.varland@varland.com"]
    }
  end

end