require 'json'

class Opto::OvenNotRequestingPower < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Oven not requesting power during warmup. Oven may not be turned on. Oven: <strong><code>#{details["oven"]}#{details["side"]}</code></strong>."
  end

end