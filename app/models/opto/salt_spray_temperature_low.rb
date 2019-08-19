require 'json'

class Opto::SaltSprayTemperatureLow < Opto::Log

  # Instance methods.

  def details
    "Salt spray temperature is low. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Salt Spray Temperature Low",
      recipients: [Opto::GREG_CELL, Opto::FOREMEN_EMAIL, Opto::RICH_CELL]
    }
  end

end