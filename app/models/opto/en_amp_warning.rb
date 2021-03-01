require 'json'

class Opto::EnAmpWarning < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Dept. 3: EN Amp Warning",
      recipients: ["brian.mangold@varland.com", "mike.mitchell.jr@varland.com", "joel.perrine@varland.com"]
    }
  end

  def details
    "EN amp warning. Limit: <strong><code>#{self.limit.to_f.round(3)} amps</code></strong>. Reading: <strong><code>#{self.opto_data[:value].to_f.round(3)} amps</code></strong>."
  end

end