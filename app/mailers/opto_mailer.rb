class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def opto_notification
    @log = params[:log]
    timestamp = Time.now.strftime("%m/%d/%y %l:%M%P")
    mail(to: @log.get_recipients,
         subject: "#{@log.notification_settings[:subject]} (#{timestamp})")
  end

end
