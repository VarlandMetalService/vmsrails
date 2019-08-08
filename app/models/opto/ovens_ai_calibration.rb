require 'json'

class Opto::OvensAiCalibration < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    fields = ["Date/Time",
              "Input",
              "Test Low Value",
              "Low Value Reading",
              "Test High Value",
              "High Value Reading",
              "Calculated Offset",
              "Calculated Gain",
              "Initials",
              "Notes"]
    values = [self.controller_timestamp.strftime("%m/%d/%y %l:%M%P"),
              details["point"],
              details["low_value_test"],
              details["low_value_reading"],
              details["high_value_test"],
              details["high_value_reading"],
              details["calculated_offset"],
              details["calculated_gain"],
              details["initials"],
              details["notes"]]
    lines = []
    0.upto(fields.length - 1) do |i|
      lines << "#{fields[i]}: <strong><code>#{values[i]}</code></strong>"
    end
    "Analog input calibrated:<br /><br />#{lines.join("<br />")}"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: AI Calibration",
      recipients: ["toby.varland@varland.com"]
    }
  end

end