class Opto::GenericOptoLog < Opto::Log

  def notification_settings
    {
      enabled: true,
      subject: "Opto Notification",
      recipients: ["toby.varland@varland.com"]
    }
  end
  
end