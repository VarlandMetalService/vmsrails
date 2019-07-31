class Opto::GenericOptoLog < Opto::Log

  def notification_settings
    {
      enabled: true,
      subject: "Opto Notification",
      recipients: ["toby.varland@varland.com", "8594964920@vtext.com"]
    }
  end
  
end