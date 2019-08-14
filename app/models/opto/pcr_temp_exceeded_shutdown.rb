require 'json'

class Opto::PcrTempExceededShutdown < Opto::Log

  # Instance methods.

  def log_type
    "PCR Temperature Exceeded & Oven Shut Down"
  end

  def details
    "Oven turned off because temperature too high for process code. Oven: <strong><code>#{self.oven}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: PCR Temp Exceeded & Oven Shut Down",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

end