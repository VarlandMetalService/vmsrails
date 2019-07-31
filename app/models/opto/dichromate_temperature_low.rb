require 'json'

class Opto::DichromateTemperatureLow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dichromate: Dichromate Tank Temperature Low",
      recipients: ["vmsforemen@gmail.com"]
    }
  end

  def details
    "Dichromate tank temperature is low. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

end