module ApplicationHelper

  def required_field_label(text)
    (text + '<sup class="text-danger">' + fa_icon('asterisk') + '</sup>:').html_safe
  end

  def page_title(separator = ' – ')
    [content_for(:title), 'VMS'].compact.join(separator)
  end

  def input_group_prepend(icon)
    content_tag :div, class: 'input-group-prepend' do
      content_tag :span, class: 'input-group-text' do
        fa_icon icon
      end
    end
  end

  def nav_link(controller, action, icon, url, method = :get)
    classes = ['nav-item']
    if current_page? controller: controller, action: action
      classes << 'active'
    end
    content_tag :li, class: classes.join(' ') do
      link_to fa_icon("#{icon} 2x"), url, class: 'nav-link p-1', method: method
    end
  end

  def part_spec_info(customer, process, part, sub_id, separator = ' &bull; ')
    if sub_id.blank?
      "#{customer}#{separator}#{process}#{separator}#{part}".html_safe
    else
      "#{customer}#{separator}#{process}#{separator}#{part}#{separator}#{sub_id}".html_safe
    end
  end

  def small_label_bold_text(label, text)
    "<small>#{label}:</small> <strong>#{text}</strong>".html_safe
  end

end
