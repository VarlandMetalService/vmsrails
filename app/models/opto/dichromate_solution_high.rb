require 'json'

class Opto::DichromateSolutionHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Solution Level High",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate solution level is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

end