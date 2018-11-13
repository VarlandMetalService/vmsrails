module OptoHelper
  def opto_email_field_value(label, value)
    "<small style=\"font-weight: 300; font-size: 0.85rem;\">#{label}:</small> <span style=\"color: #e83e8c; font-family: SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace; font-size: 0.875rem; font-weight: 700;\">#{value}</span>".html_safe
  end
end
