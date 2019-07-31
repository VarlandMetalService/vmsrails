require 'json'

class Opto::RoLevelHigh < Opto::Log

  # Instance methods.

  def details
    "RO tank solution level is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&Prime;</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&Prime;</code></strong>."
  end

end