require 'json'

class Opto::ChillerOffWarning < Opto::Log

  # Instance methods.

  def details
    "Chiller not running when expected. Chiller: <strong><code>#{self.opto_data[:chiller]}</code></strong>."
  end

end