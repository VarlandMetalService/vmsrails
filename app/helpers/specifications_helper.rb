module SpecificationsHelper

  def thickness(thickness, unit)
    return "" if thickness.blank?
    calculated = thickness
    case unit
    when 'µm'
      calculated *= 0.0000393701
      "#{number_with_precision(calculated.round(thickness < 2.5 ? 5 : 4), precision: 5)}&Prime;<br /><small class=\"text-muted\">(#{thickness == thickness.to_i ? thickness.to_i : thickness}µm)</small>".html_safe
    else
      "#{number_with_precision(calculated, precision: 5)}&Prime;".html_safe
    end
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
      html << "<br /><small class=\"text-muted\">(#{setpoint}#{unit}"
      unless variation_limit.blank?
        html << " &plusmn; #{variation_limit.to_i}#{unit}"
      end
      html << ")</small>"
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

end
