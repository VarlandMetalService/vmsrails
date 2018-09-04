module PrintQueue::PrintJobRulesHelper

  def string_rep(print_job)
    if print_job.var1_type == 2
      print_job.var1 = string_rep(PrintQueue::PrintJobRule.find(print_job.var1))
    end
    if print_job.var2_type == 2
      print_job.var2 = string_rep(PrintQueue::PrintJobRule.find(print_job.var2))
    end
    return "#{print_job.var1} #{print_job.operator} #{print_job.var2}"
  end
end

