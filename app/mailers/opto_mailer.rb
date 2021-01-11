class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def opto_notification
    @log = params[:log]
    if @log.notification_settings[:recipients].include?(Opto::FOREMEN_EMAIL)
      @log.notification_settings[:recipients].delete(Opto::FOREMEN_EMAIL)
      uri = "http://timeclock.varland.com/foremen_email.json"
      response = Net::HTTP.get(uri)
      addresses = JSON.parse(response)
      @addresses.each do |email|
        @log.notification_settings[:recipients] << email
      end
    end
    timestamp = Time.now.strftime("%m/%d/%y %l:%M%P")
    mail(to: @log.notification_settings[:recipients],
         subject: "#{@log.notification_settings[:subject]} (#{timestamp})")
  end

end
