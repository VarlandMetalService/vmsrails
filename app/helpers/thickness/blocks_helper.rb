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
      thickness_sum += (output[0].to_f - c.thickness)
      alloy_sum += (output[4].to_f - c.alloy_percentage) unless c.alloy_percentage.blank?
    end
    output[3] = "%.1e" % (thickness_sum.to_f/checks.length)
    output[7] = "%.1e" % (alloy_sum.to_f/checks.length)

    if checks.first.alloy_percentage.blank?
      output[4] = "N/A"
      output[5] = "N/A"
      output[6] = "N/A"
      output[7] = "N/A"
    end

    return output
  end
end