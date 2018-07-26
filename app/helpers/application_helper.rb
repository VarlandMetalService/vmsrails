module ApplicationHelper

  def highlight_unless_nil(text, terms, options = { highlighter: '<mark class="bold">\1</mark>' })
    return text if terms.nil?
    highlight(text, terms[:include], highlighter: options[:highlighter])
  end

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
    #if current_page? controller: controller, action: action
    #  classes << 'active'
    #end
    content_tag :li, class: classes.join(' ') do
      link_to fa_icon("#{icon} 2x"), url, class: 'nav-link p-1', method: method
    end
  end

  def part_spec_info(customer, process, part, sub_id, separator = ' &bull; ')
    parts = []
    parts << customer unless customer.blank?
    parts << process unless process.blank?
    parts << part unless part.blank?
    parts << sub_id unless sub_id.blank?
    parts.join(separator).html_safe
  end

  def small_label_bold_text(label, text)
    "<small>#{label}:</small> <strong>#{text}</strong>".html_safe
  end

  def opto_email_field_value(label, value)
    "<small style=\"font-weight: 300; font-size: 0.85rem;\">#{label}:</small> <span style=\"color: #e83e8c; font-family: SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace; font-size: 0.875rem; font-weight: 700;\">#{value}</span>".html_safe
  end

  def split_search_terms(input)
    search = {
      include: [],
      exclude: []
    }
    terms = input.split(/\s(?=(?:[^"]|"[^"]*")*$)/)
    terms.each do |t|
      if t[0..1] == '--'
        search[:exclude] << t[2..-1].gsub(/\A"|"\Z/, '')
      else
        search[:include] << t.gsub(/\A"|"\Z/, '')
      end
    end
    search
  end

  def inches_to_half_micron(inches)
    calculated = inches.to_f * 25400
    rounded = (calculated * 2).round / 2.0
    return rounded
  end

  def split_numeric_terms(input)
    terms = input.split(/^\s*([>!=<]*)\s*(\d*\.?\d+)\s*(-)?\s*(\d*\.?\d+)?\s*$/)
    search = nil
    functions = {}
    functions['>='] = 'gte'
    functions['>'] = 'gt'
    functions['<='] = 'lte'
    functions['<'] = 'lt'
    functions['='] = 'eq'
    functions['=='] = 'eq'
    functions['!='] = 'ne'
    functions['<>'] = 'ne'
    case terms.size
    when 3
      function ||= functions[terms[1]]
      if function.nil?
        search = {
          function: 'eq',
          value: terms[2]
        }
      else
        search = {
          function: function,
          value: terms[2]
        }
      end
    when 5
      search = {
        function: 'range',
        minimum: terms[2],
        maximum: terms[4]
      }
    end
    return search
  end

  def prod_date
    t = Time.now
    if t.hour < 7 || t.hour > 23
      return Date.yesterday
    else  
      return Date.today
    end
  end

  def prod_shift
    t = Time.now
    if t.hour < 7 || t.hour > 23
      return 3
    elsif t.hour >= 7 && t.hour <= 15
      return 1
    else
      return 2
    end
  end
end
