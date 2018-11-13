module Thickness::BlocksHelper
  # Returns an array [tmean, tmin, tmax, tstd, amean, amin, amax, astd]
  def calculate_mean(checks)
    output = []
    thickness_sum = 0
    alloy_sum = 0

    checks.each do |c|
      thickness_sum += c.thickness
      alloy_sum += c.alloy_percentage unless c.alloy_percentage.blank?

      if output[1].blank? || c.thickness < output[1]
        output[1] = c.thickness
      end
      if output[2].blank? || c.thickness > output[2]
        output[2] = c.thickness
      end
      if c.alloy_percentage.blank?
      else
        if output[5].blank? || c.alloy_percentage < output[5]
          output[5] = c.alloy_percentage
        end
        if output[6].blank? || c.alloy_percentage > output[6]
          output[6] = c.alloy_percentage
        end
      end
    end
    output[0] = number_with_precision(thickness_sum.to_f/checks.length, precision: 4)
    output[4] = number_with_precision(alloy_sum.to_f/checks.length, precision: 4)

    thickness_sum = 0
    alloy_sum = 0
    checks.each do |c|
      thickness_sum += (c.thickness - output[0].to_f)**2
      alloy_sum += (c.alloy_percentage - output[4].to_f)**2 unless c.alloy_percentage.blank?
    end
    output[3] = "%.1e" % Math.sqrt(thickness_sum.to_f/checks.length)
    output[7] = "%.1e" % Math.sqrt(alloy_sum.to_f/checks.length)

    if checks.first.alloy_percentage.blank?
      output[4] = "N/A"
      output[5] = "N/A"
      output[6] = "N/A"
      output[7] = "N/A"
    end

    return output
  end

  def results_set(checks)
    results = calculate_mean(checks)
    return "<tr clas='mb-0 mt-0'>
      <td class='text-right'>Thickness:</td>
      <td class='text-right'>#{results[0]}</td>
      <td class='text-right'>#{results[1]}</td>
      <td class='text-right'>#{results[2]}</td>
      <td class='text-right'>#{results[3]}</td>
    </tr>
    <tr>
      <td class='text-right'>Alloy %:</td>
      <td class='text-right'>#{results[4]}</td>
      <td class='text-right'>#{results[5]}</td>
      <td class='text-right'>#{results[6]}</td>
      <td class='text-right'>#{results[7]}</td>
    </tr>".html_safe
  end

  def is_rw(block)
    if block.is_rework
      "<div class='text-danger d-inline'>
        RW
      </div>".html_safe
    end
  end

  def customer_cell(block)
    if block.customer.blank?
      "<div class='col-12 text-center'>
        Customer info (from API) unavailable.
      </div>".html_safe
    else
    "<div class='col-7'>
      Load Weight: #{block.load_weight} <br>
      Piece Weight: #{block.piece_weight} <br>
      Part Area: #{block.part_area} 
    </div>
    <div class='col-5'>
      <strong class='text-center'>#{block.customer}</strong> -
      <div class='text-muted d-inline'>
        #{block.process}<br>
      </div>
      #{block.part} #{block.sub} <br>
        Density: #{((block.piece_weight.to_f/32.2)/(block.part_area.to_f*block.checks.first.thickness)).round(2)}
    </div>".html_safe
  end 
  end
end