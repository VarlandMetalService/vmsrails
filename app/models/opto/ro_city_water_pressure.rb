require 'json'

class Opto::RoCityWaterPressure < Opto::Log

  # Instance methods.

  def details
    "City water pressure dropped in the RO system, so the RO system cannot run."
  end

end