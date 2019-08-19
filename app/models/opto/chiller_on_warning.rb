require 'json'

class Opto::ChillerOnWarning < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: false,
      subject: "Chiller: Running When Not Expected",
      recipients: ["vmsforemen@gmail.com", "5138140536@vtext.com", "5132849588@vtext.com", "5135689345@txt.att.net"]
    }
  end

  def details
    "Chiller running when not expected. Chiller: <strong><code>#{self.opto_data[:chiller]}</code></strong>."
  end

end