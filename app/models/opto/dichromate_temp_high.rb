require 'json'

class Opto::DichromateTempHigh < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Tank Temperature High",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate tank temperature is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

end