module SaltSprayTestsHelper
  # Returns an array of either "x days" or "x hours" depending on 
  #   divisibility e.g. [white_spec, red_spec, units]
  def format_spec(test)
    if test.blank? 
    else
      results = []
      if test.white_spec.modulo(24).zero? && test.red_spec.modulo(24).zero?
        results[0] = pluralize(test.white_spec/24, "day")
        results[1] = pluralize(test.red_spec/24, "day")
        results[3] = "day"
      else
        results[0] = pluralize(test.white_spec, "hour")
        results[1] = pluralize(test.red_spec, "hour")
        results[3] = "hour"
      end
      return results
    end
  end
end