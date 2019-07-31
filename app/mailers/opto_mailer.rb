class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def opto_notification
    @log = params[:log]
    mail(to: @log.notification_settings[:recipients],
         subject: @log.notification_settings[:subject])
  end

end
