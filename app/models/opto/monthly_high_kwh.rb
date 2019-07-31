require 'json'

class Opto::MonthlyHighKwh < Opto::Log

  # Instance methods.

  def details
    "New KWH high for month: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} KWH</code></strong>."
  end

  def log_type
    "High KWH Reading for Month"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Energy: New KWH Maximum for Month",
      recipients: ["toby.varland@varland.com"]
    }
  end

end