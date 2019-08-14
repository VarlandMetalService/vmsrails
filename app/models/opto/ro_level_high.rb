require 'json'

class Opto::RoLevelHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Solution Level High",
      recipients: [Opto::FOREMAN_EMAIL,
                   Opto::LAB_EMAIL,
                   Opto::RICH_CELL]
    }
  end

  def log_type
    "RO Solution Level High"
  end

  def details
    "RO tank solution level is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

end