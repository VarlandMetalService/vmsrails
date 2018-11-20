module SpecificationsHelper

  def thickness(thickness, unit)
    return "" if thickness.blank?
    calculated = thickness
    case unit
    when 'µm'
      calculated *= 0.0000393701
      #"#{number_with_precision(calculated.round(thickness < 2.5 ? 5 : 4), precision: 5)}&Prime;<br /><small class=\"text-muted\">(#{thickness == thickness.to_i ? thickness.to_i : thickness}µm)</small>".html_safe
      "#{number_with_precision(calculated.round(thickness < 2.5 ? 5 : 4), precision: 5)}&Prime;".html_safe
    else
      "#{number_with_precision(calculated, precision: 5)}&Prime;".html_safe
    end
  end

  def inches_to_half_micron(inches)
    calculated = inches.to_f * 25400
    rounded = (calculated * 2).round / 2.0
    return rounded
  end

  def temperature(setpoint, variation_limit, unit)
    return "" if setpoint.blank?
    variation_limit = 0 if variation_limit.blank?
    calc_setpoint = setpoint
    calc_variation_limit = variation_limit
    case unit
    when 'º C'
      calc_setpoint *= 1.8
      calc_setpoint += 32
      calc_variation_limit *= 1.8
      html = "#{calc_setpoint.to_i}"
      unless variation_limit.blank?
        html << " &plusmn; #{calc_variation_limit.to_i}"
      end
      #html << "<br /><small class=\"text-muted\">(#{setpoint}#{unit}"
      #unless variation_limit.blank?
      #  html << " &plusmn; #{variation_limit.to_i}#{unit}"
      #end
      #html << ")</small>"
    else
      html = "#{calc_setpoint.to_i}"
      unless variation_limit.blank?
        html << " &plusmn; #{calc_variation_limit.to_i}"
      end
    end
    html.html_safe
  end

  def bake_time(time)
    return "" if time.blank?
    calculated = time / 60.0
    if calculated == calculated.to_i
      "#{calculated.to_i}".html_safe
    else
      "#{number_with_precision(calculated, precision: 1)}".html_safe
    end
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

end
