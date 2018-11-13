module Admin::PermissionsHelper
  def required_field_label(text)
    (text + '<sup class="text-danger">' + fa_icon('asterisk') + '</sup>:').html_safe
  end
end

