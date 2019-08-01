require 'json'

class Opto::MonthlyHighKwh < Opto::Log

  # Instance methods.

  def details
    "New KWH high for month: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} KWH</code></strong>."
  end

  def log_type
    "Monthly High KWH"
  end

  def notification_settings
    {
      enabled: false,
      subject: "Energy: New KWH Maximum for Month",
      recipients: ["toby.varland@varland.com", "joel.perrine@varland.com", "rich.branson@varland.com", "brian.mangold@varland.com"]
    }
  end

end