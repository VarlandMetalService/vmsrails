require 'json'

class Opto::ChillerOffWarning < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: false,
      subject: "Chiller: Not Running When Expected",
      recipients: ["vmsforemen@gmail.com", "5138140536@vtext.com", "5132849588@vtext.com", "5135689345@txt.att.net"]
    }
  end

  def details
    "Chiller not running when expected. Chiller: <strong><code>#{self.opto_data[:chiller]}</code></strong>."
  end

end