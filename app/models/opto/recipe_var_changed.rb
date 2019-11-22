require 'json'

class Opto::RecipeVarChanged < Opto::Log

  # Instance methods.

  def log_type
    "Recipe Variable Changed"
  end

  def details
    details = ::ActiveSupport::JSON.decode(self.json_data)
    "Recipe variable changed. Variable: <strong><code>#{details["var"]}</code></strong>. From: <strong><code>#{details["old"]}</code></strong>. To: <strong><code>#{details["new"]}</code></strong>."
  end

  def notification_settings
    {
      enabled: true,
      subject: "Recipe Variable Changed",
      recipients: [Opto::TOBY_EMAIL, Opto::TOBY_CELL]
    }
  end

end