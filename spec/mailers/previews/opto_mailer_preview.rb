class OptoMailerPreview < ActionMailer::Preview
  def dichromate_solution_low
    OptoMailer.with(log: Opto::DichromateSolutionLow.first).dichromate_solution_low
  end
end