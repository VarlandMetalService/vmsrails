module Thickness::BlocksHelper

  # Logic functions
    # Returns an array [tmean, tmin, tmax, tstd, amean, amin, amax, astd]
    def calculate_check_stats(checks)
      output = []
      thickness_sum = 0
      alloy_sum = 0
      temps = checks.map { |c| [c.thickness, c.alloy_percentage]}.transpose

      if temps[0][0].blank?
        output[0] = "N/A"
        output[1] = "N/A"
        output[2] = "N/A"
        output[3] = "N/A"
      else
        # Thickness mean
        output[0] = number_with_precision(temps[0].sum.to_f/temps[0].length, precision: 4)
        # Thickness min
        output[1] = temps[0].min
        # Thickness max
        output[2] = temps[0].max

          temps[0].each do |t|
            thickness_sum += (t.to_f - output[0].to_f)**2
          end

        # Thicknes std. dev
        output[3] = "%.1e" % Math.sqrt(thickness_sum.to_f/temps[0].length)
      end

      if temps[1][0].blank?
        output[4] = "N/A"
        output[5] = "N/A"
        output[6] = "N/A"
        output[7] = "N/A"
      else
        # Alloy % mean
        output[4] = number_with_precision(temps[1].sum.to_f/temps[0].length, precision: 4)
        # Alloy % min
        output[5] = temps[1].min
        # Alloy % max
        output[6] = temps[1].max

          temps[1].each do |a|
            alloy_sum += (a.to_f - output[4].to_f)**2
          end

        # Alloy % std. dev
        output[7] = "%.1e" % Math.sqrt(alloy_sum.to_f/temps[1].length)
      end

      return output
    end

    # Decorators
    def results_table(block)
      results = calculate_check_stats(block.checks)
      return "<tbody>
          <tr clas='mb-0 mt-0'>
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
        </tr>
        </tbody>".html_safe
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

    def is_rw(block)
      if block.is_rework
        "<div class='text-danger d-inline'>
          RW
        </div>".html_safe
      end
    end
end