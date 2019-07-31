require 'json'

class Opto::DichromateTemperatureHigh < Opto::Log

  # Instance methods.

  def details
    "Dichromate tank temperature is high. High limit: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.limit}&deg; F</code></strong>. Reading: <strong><code>#{::ActiveSupport::NumberHelper::number_to_delimited self.reading}&deg; F</code></strong>."
  end

end