require 'json'

class Opto::BadOvenProbe < Opto::Log

  # Instance methods.

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    probes = []
    details["probes"].each_with_index do |name, index|
      unless name.blank?
        probes << "Probe Name: <strong><code>#{name}</code></strong>, Reading: <strong><code>#{details["readings"][index]}</code></strong>"
      end
    end
    "Suspected bad temperature probe.<br />#{probes.join("<br />")}"
  end

  def notification_settings
    {
      enabled: true,
      subject: "Ovens: Bad Temperature Probe",
      recipients: ["toby.varland@varland.com", "8594964920@vtext.com"]
    }
  end

end