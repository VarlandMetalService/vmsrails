module SaltSprayTestsHelper
  # Returns an array of either 'x days' or 'x hours' depending on 
  #   divisibility e.g. [white_spec, red_spec, units]
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
        + "#{k}"
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

  def ok_button(s, f)
    if s.salt_spray_test_checks.where(:c_type => 'OFF').blank?
      "#{ f.submit 'OK', 
      { class: 'btn btn-primary swipe-btn btn-block border',
        data: { 
          confirm: 'Mark' + %Q[#{s.so_num}] + ' as OK?', 
          toggle: 'tooltip', 
          title: 'Mark as OK' } } }".html_safe
    else
       "#{ f.submit 'ok', 
            { class: 'btn btn-primary swipe-btn btn-block border',
              disabled: true, 
              data: { 
                confirm: 'Mark' + %Q[#{s.so_num}] + ' as WHITE?', 
                toggle: 'tooltip', 
                title: 'Mark as OK' } } }".html_safe
    end 
  end

  def white_button(s, f)
    if s.salt_spray_test_checks.where(:c_type => 'WHITE').blank?
    "#{ f.submit 'WHITE', 
    { class: 'btn swipe-btn btn-block border',
      data: { 
        confirm: 'Mark' + %Q[#{s.so_num}] + ' as WHITE?', 
        toggle: 'tooltip', 
        title: 'Mark as WHITE' } } }".html_safe
    else
     "#{ f.submit 'white', 
          { class: 'btn swipe-btn btn-block border',
            disabled: true, 
            data: { 
              confirm: 'Mark' + %Q[#{s.so_num}] + ' as WHITE?', 
              toggle: 'tooltip', 
              title: 'Mark as WHITE' } } }".html_safe
    end
  end

  def red_button(s, f)
    if s.salt_spray_test_checks.where(:c_type => 'RED').blank?
      "#{ f.submit 'RED', 
      { class: 'btn btn-danger swipe-btn btn-block border',
        data: { 
          confirm: 'Mark' + %Q[#{s.so_num}] + ' as RED?', 
          toggle: 'tooltip', 
          title: 'Mark as RED' } } }".html_safe
    else
      "#{ f.submit 'red', 
      { class: 'btn btn-danger swipe-btn btn-block border',
        disabled: true, 
        data: { 
          confirm: 'Mark' + %Q[#{s.so_num}] + ' as RED?', 
          toggle: 'tooltip', 
          title: 'Mark as RED' } } }".html_safe
    end
  end

  def off_button(s, f)
    if s.salt_spray_test_checks.where(:c_type => 'OFF').blank?
      "#{ f.submit 'OFF', 
      { class: 'btn btn-success swipe-btn btn-block border',
        data: { 
          confirm: 'Mark' + %Q[#{s.so_num}] + ' as OFF?', 
          toggle: 'tooltip', 
          title: 'Mark as OFF' } } }".html_safe
    else
      "#{ f.submit 'off', 
      { class: 'btn btn-success swipe-btn btn-block border',
        disabled: true, 
        data: { 
          confirm: 'Mark' + %Q[#{s.so_num}] + ' as OFF?', 
          toggle: 'tooltip', 
          title: 'Mark as OFF' } } }".html_safe
    end
  end

  def is_desktop(s, type)
    if type == "desktop"
      "<button class='btn btn-dark' style='height: 40px;' type='button' data-toggle='collapse' data-target='.checks-collapse#{s.id}'>
        #{fa_icon('list')}
      </button>".html_safe
    end
  end

  def red_bar_step(s, specs)
    if s.red_spec == 0 || s.red_spec.blank? 
      s.red_spec = 4*s.white_spec
    else
      message = "<div class='bar-step clearfix' style='left: 75%; overflow:hidden;'>
        <div class='label-txt'>
          Red
          <div class='label-line'></div>
        </div>" 
        x = s.salt_spray_test_checks.where(:c_type => 'RED')
        if x.blank? && (((Time.now() - s.created_at)/60.minutes) < s.red_spec)
          message += "<div class='label-percent'> #{specs[1]} </div>"
        elsif !x.blank? && ((x.first.date - s.created_at).to_f/60.minutes < s.red_spec)
          message += "<span class='label-percent text-danger'>#{fa_icon('times')}</span>"
        else
          message+ "<span class='label-percent text-success'>#{fa_icon('check')}</span>"
        end
        message += "</div>"
        return message.html_safe
    end
  end

  def white_bar_step(s, specs)
    if s.red_spec == 0
      s.red_spe = 4*s.white_spec
    end
    if s.white_spec == 0
    else
      message = "<div class='bar-step clearfix' style='left: #{75*(s.white_spec.to_f/s.red_spec)}%'>
        <div class='label-txt'>
          White
          <div class='label-line'></div>
        </div>
        <div class='label-percent'>"
          x = s.salt_spray_test_checks.where(:c_type => 'WHITE')
          if x.blank? && ((Time.now() - s.created_at)/60.minutes) < s.white_spec
            specs[0]
          elsif !x.blank? && (x.first.date - s.created_at).to_f/60.minutes < s.white_spec
            message +=  "<span class='label-percent text-danger'> #{fa_icon('times')}</span>"
          else
            message +=  "<span class='label-percent text-success'>#{fa_icon('check')}</span>"
          end
        message += "</div>
      </div>"
      return message.html_safe
    end
  end
end