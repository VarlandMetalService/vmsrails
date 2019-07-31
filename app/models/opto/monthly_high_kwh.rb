require 'json'

class Opto::MonthlyHighKwh < Opto::Log

  # Instance methods.

  def details
    "New KWH high for month: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Energy: New KWH Maximum for Month",
      recipients: ["toby.varland@varland.com"]
    }
  end

end