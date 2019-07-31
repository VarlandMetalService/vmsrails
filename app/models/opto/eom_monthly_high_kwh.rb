require 'json'

class Opto::EomMonthlyHighKwh < Opto::Log

  # Instance methods.

  def details
    "Highest KWH reading in previous month: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} KWH</code></strong> @ <strong><code>#{self.controller_timestamp.strftime("%m/%d/%Y %I:%M%P")}</code></strong>."
  end

  def log_type
    "EOM Monthly High KWH"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Energy: KWH High for Previous Month",
      recipients: ["toby.varland@varland.com"]
    }
  end

end