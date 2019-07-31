require 'json'

class Opto::RoLevelLow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO Solution Level Low",
      recipients: ["toby.varland@varland.com"]
    }
  end

  def log_type
    "RO Solution Level Low"
  end

  def details
    "RO tank solution level is low. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

end