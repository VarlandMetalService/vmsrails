require 'json'

class Opto::OvensIoError < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    bricks = []
    bricks << "<strong><code>Warehouse Brick</code></strong>" if details["warehouse"] == 0
    bricks << "<strong><code>IAO Brick</code></strong>" if details["iao"] == 0
    bricks << "<strong><code>Small Ovens Brick</code></strong>" if details["small_ovens"] == 0
    bricks << "<strong><code>Dichromate Brick</code></strong>" if details["dichromate"] == 0
    "I/O error on ovens controller.<br /><br />#{bricks.join("<br />")}"
  end

  def log_type
    "Ovens IO Error"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: I/O Error",
      recipients: [Opto::FOREMEN_EMAIL, Opto::TOBY_EMAIL]
    }
  end

end