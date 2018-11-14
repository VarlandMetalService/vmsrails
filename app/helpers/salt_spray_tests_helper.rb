module SaltSprayTestsHelper
  # Logic functions
    # Returns an array of either 'x days' or 'x hours' depending on divisibility e.g. [white_spec, red_spec, units]
    def format_spec(test)
      if test.blank? 
      else
        results = []
        if test.white_spec.modulo(24).zero? && test.red_spec.modulo(24).zero?
          results[0] = pluralize(test.white_spec/24, 'day')
          results[1] = pluralize(test.red_spec/24, 'day')
          results[3] = 'day'
        else
          results[0] = pluralize(test.white_spec, 'hour')
          results[1] = pluralize(test.red_spec, 'hour')
          results[3] = 'hour'
        end
        return results
      end
    end

  def title(s)
    if s.is_sample? || !s.sample_code.blank?
      "<p class='text-center mb-1' style='font-size: 16px;'>
        <strong>
          #{fa_icon('flask', text: %Q[#{s.so_num} - #{s.sample_code}])}
        </strong>
      </p>".html_safe
    else
      "<p class='text-center mb-1' style='font-size: 20px;'>
        <strong>
          #{s.so_num}
        </strong>
      </p>".html_safe
    end
  end

  def sub_title(s)
    if s.sample_code.blank?
      "#{s.so_num}".html_safe
    else
     "#{fa_icon('flask')} #{s.so_num} - #{s.sample_code}".html_safe
    end
  end

  def process_steps(s)
    if s.process.blank? || s.process[0].blank? 
      "No process entered."
    else
      "<u>Process</u><br>" + 
      s.process.each_with_index do |k,p|
        + "#{p+1}: #{k}"
        if p == s.process.count-1
        else
        + "<br>" 
        end
      end
    end
  end

  def process_badge(s)
    "<a href='#' data-process-code='#{s.process_code}' title='Filter by process code' class='process-code-filter font-weight-bold'>
      <span class='badge badge-warning badge-border float-left mr-2 mt-2 btn-block' style='font-size: 35px;  border: 5px solid #343a40;'>
        #{s.process_code}
      </span>
    </a>".html_safe unless s.process_code.blank?
  end

  def button(s, f, type, text)
    case type
    when "block"
      class_string = 'swipe-btn btn-block border'
    when "dropdown"
      class_string = 'btn-sm dropdown-item'
    end

    case text 
    when "OK"
      color = "btn-primary "
    when "WHITE"
      color = " "
    when "RED"
      color = "btn-danger "
    when "OFF"
      color = "btn-success "
    end

    x = s.salt_spray_test_checks.group_by(&:c_type)
    if (!x["OFF"].blank?) || 
      ((!x["RED"].blank?) && (text == "RED" || text == "WHITE")) ||
      (!x["WHITE"].blank? && (text == "WHITE"))
      "#{ f.submit %Q[#{text}], 
          { class: 'btn ' + %Q[#{color}] + %Q[#{class_string}],
            disabled: true, 
            data: { 
              confirm: 'Mark ' + %Q[#{s.so_num}] + ' as ' + %Q[#{text}] + '?',
              toggle: 'tooltip', 
              title: 'Mark as ' + %Q[#{text}] } } }".html_safe
    else
      "#{ f.submit %Q[#{text}], 
      { class: 'btn ' + %Q[#{color}] + %Q[#{class_string}],
        data: { 
          confirm: 'Mark ' + %Q[#{s.so_num}] + ' as ' + %Q[#{text}] + '?', 
          toggle: 'tooltip', 
          title: 'Mark as ' + %Q[#{text}] } } }".html_safe
    end
  end

  # Progress Bar Functions
  def progress_bar_is_desktop(s, type)
    "<button class='btn btn-dark' style='height: 40px;' type='button' data-toggle='collapse' data-target='.checks-collapse#{s.id}'>
      #{fa_icon('list')}
    </button>".html_safe unless type != "desktop"
  end

  def progress_bar_red_label(s, specs)
    if s.red_spec == 0 || s.red_spec.blank? 
      s.red_spec = 4*s.white_spec
    end
  end

  def progress_bar_labels(s, specs)
    message = ""
    x = s.salt_spray_test_checks.group_by(&:c_type)
    if s.red_spec == 0
      s.red_spec = 4*s.white_spec
    else
      message += "<div class='bar-step clearfix' style='left: 75%; overflow:hidden;'>
        <div class='label-txt'>
          Red
          <div class='label-line'></div>
        </div>
        <div class='label-percent'>" 
        if x["RED"].blank? && (((Time.now() - s.created_at)/60.minutes) < s.red_spec)
          message += specs[1]
        elsif !x["RED"].blank? && ((x["RED"].first.date - s.created_at).to_f/60.minutes < s.red_spec)
          message += "<span class='label-percent text-danger'>
                        #{fa_icon('times')}</span>"
        else
          message += "<span class='label-percent text-success'>
                        #{fa_icon('check')}</span>"
        end
        message += "</div></div>"
    end
    if s.white_spec == 0
    else
      message += "<div class='bar-step clearfix' style='left: #{75*(s.white_spec.to_f/s.red_spec)}%'>
        <div class='label-txt'>
          White
          <div class='label-line'></div>
        </div>
        <div class='label-percent'>"
          if x["WHITE"].blank? && ((Time.now() - s.created_at)/60.minutes) < s.white_spec
            message += specs[0]
          elsif !x["WHITE"].blank? && (x["WHITE"].first.date - s.created_at).to_f/60.minutes < s.white_spec
            message +=  "<span class='label-percent text-danger'> 
                            #{fa_icon('times')}</span>"
          else
            message +=  "<span class='label-percent text-success'>
                            #{fa_icon('check')}</span>"
          end
        message += "</div></div>"
    end
    return message.html_safe
  end

  def progress_bar_main_label(s, specs)
    if specs[3] == 'day'
        pluralize((((Time.now() - s.created_at)/24.hours).round ), specs[3])
    else
        pluralize((((Time.now() - s.created_at)/60.minutes).round ), specs[3])
    end
  end

end