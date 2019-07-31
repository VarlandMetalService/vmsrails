require 'json'

class Opto::DichromateSolutionLow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Solution Level Low",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate solution level is low. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

end