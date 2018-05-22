class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
 
  def dichromate_solution_low
    @log = params[:log]
    mail(to: ['toby.varland@varland.com', '8594964920@vtext.com'], subject: 'Opto Warning: Dichromate Solution Level Low')
  end
end
