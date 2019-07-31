require 'json'

class Opto::SaltSprayTemperatureHigh < Opto::Log

  # Instance methods.

  def details
    "Salt spray temperature is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Salt Spray Temperature High",
      recipients: ["toby.varland@varland.com"]
    }
  end

end