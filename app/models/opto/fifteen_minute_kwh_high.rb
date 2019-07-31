require 'json'

class Opto::FifteenMinuteKwhHigh < Opto::Log

  # Instance methods.

  def details
    "15 minute KWH reading high: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} KWH</code></strong>."
  end

  def log_type
    "15 Minute KWH High"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Energy: 15 Minute KWH High",
      recipients: ["toby.varland@varland.com", "joel.perrine@varland.com", "rich.branson@varland.com", "brian.mangold@varland.com", "vmsforemen@gmail.com"]
    }
  end

end