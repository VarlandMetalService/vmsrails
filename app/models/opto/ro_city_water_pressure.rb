require 'json'

class Opto::RoCityWaterPressure < Opto::Log

  # Instance methods.

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: RO City Water Pressure Problem",
      recipients: ["toby.varland@varland.com", "5134768439@vtext.com"]
    }
  end

  def log_type
    "RO City Water Pressure Problem"
  end

  def details
    "City water pressure dropped in the RO system, so the RO system cannot run."
  end

end