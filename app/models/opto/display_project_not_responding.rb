require 'json'

class Opto::DisplayProjectNotResponding < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "PAC Display project is not responding. Project: <strong><code>#{details["project"]}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Display Project Not Responding",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

end