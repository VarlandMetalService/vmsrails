require 'json'

class Opto::PcrTempExceeded < Opto::Log

  # Instance methods.

  def log_type
    "PCR Temperature Exceeded"
  end

  def details
    "Oven denied power because temperature too high for process code. Oven: <strong><code>#{self.oven}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: PCR Temp Exceeded",
      recipients: ["toby.varland@varland.com"]
    }
  end

end