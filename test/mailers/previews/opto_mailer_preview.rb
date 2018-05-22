# Preview all emails at http://localhost:3000/rails/mailers/opto_mailer
class OptoMailerPreview < ActionMailer::Preview
  def dichromate_solution_low
    OptoMailer.with(log: Opto::DichromateSolutionLow.first).dichromate_solution_low
  end
end
