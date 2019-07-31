require 'json'

class Opto::DichromateScheduledTempControl < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Turned on temperature control at scheduled time: <strong><code>#{details["scheduled_time"]}</code></strong>."
  end

end