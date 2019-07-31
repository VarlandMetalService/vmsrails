require 'json'

class Opto::OvenWarmupTooLong < Opto::Log

  # Instance methods.

  def log_type
    "Warmup Taking Too Long"
  end

  def details
    "An oven is taking longer than expcted to warm up. Oven: <strong><code>#{self.oven}#{self.side}</code></strong>. Limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit} seconds</code></strong>. So Far: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading} seconds</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Warmup Taking Too Long",
      recipients: ["toby.varland@varland.com"]
    }
  end

end