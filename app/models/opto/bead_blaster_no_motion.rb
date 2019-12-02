require 'json'

class Opto::BeadBlasterNoMotion < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Bead blaster turned off due to no motion. Bead Blaster: <strong><code>#{details["bead_blaster"]}</code></strong>."
  end

  def log_type
    "Bead Blaster No Motion"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Bead Blaster Turned Off Because No Motion",
      recipients: [Opto::FOREMEN_EMAIL]
    }
  end

end