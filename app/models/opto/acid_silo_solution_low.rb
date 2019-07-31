require 'json'

class Opto::AcidSiloSolutionLow < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Acid Silo: Solution Low",
      recipients: ["rich.branson@varland.com"]
    }
  end

  def details
    "Acid silo solution level is low. Silo: <strong><code>#{self.opto_data[:silo]}</code></strong>. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} gallons</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} gallons</code></strong>."
  end

end