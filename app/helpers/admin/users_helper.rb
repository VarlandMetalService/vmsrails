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

end