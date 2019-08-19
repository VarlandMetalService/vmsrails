require 'json'

class Opto::OvenKwhHighRestricted < Opto::Log

  # Instance methods.

  def log_type
    "Oven Power Restricted Because KWH High"
  end

  def details
    "Oven denied power because energy usage too high. Oven: <strong><code>#{self.oven}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} KWH</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}KWH</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Power Restricted Because KWH High",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

end