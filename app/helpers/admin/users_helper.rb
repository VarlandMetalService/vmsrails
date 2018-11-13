module Admin::UsersHelper
  
  def badge(user)
    if user.blank?
      return '&nbsp;'
    else
      return "<span class='badge badge-pill'
                style='color: #{user.avatar_text_color}; 
                background-color: #{user.avatar_bg_color};'>
              #{user.initials} 
              </span>".html_safe
    end
  end

  def small_label_bold_text(label, text)
    "<small>#{label}:</small> <strong>#{text}</strong>".html_safe
  end

  def required_field_label(text)
    (text + '<sup class="text-danger">' + fa_icon('asterisk') + '</sup>:').html_safe
  end

end