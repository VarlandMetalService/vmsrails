require 'json'

class Opto::DichromateNoTempControl < Opto::Log

  # Instance methods.

  def details
    "Load went into dichromate without temperature control and with low temperature. Opto turned on temp control. Low limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

end