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
      recipients: [Opto::FOREMEN_EMAIL,
                   Opto::JOEL_EMAIL,
                   Opto::RICH_CELL,
                   Open::BRIAN_CELL]
    }
  end

end