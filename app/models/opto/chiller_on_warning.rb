require 'json'

class Opto::ChillerOnWarning < Opto::Log

  # Instance methods.

  def details
    "Chiller running when not expected. Chiller: <strong><code>#{self.opto_data[:chiller]}</code></strong>."
  end

end