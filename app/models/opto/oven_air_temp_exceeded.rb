require 'json'

class Opto::OvenAirTempExceeded < Opto::Log

  # Instance methods.

  def details
    "Oven denied power because air temperature too high. Oven: <strong><code>#{self.oven}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Air Temp Exceeded",
      recipients: ["toby.varland@varland.com"]
    }
  end

end