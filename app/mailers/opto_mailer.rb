class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def opto_notification
    @log = params[:log]
    if @log.notification_settings[:recipients].include?("vmsforemen@gmail.com")
      @log.notification_settings[:recipients].delete("vmsforemen@gmail.com")
      escaped_url = URI.escape("http://timeclock.varland.com/foremen_email.json")
      uri = URI.parse(escaped_url)
      response = Net::HTTP.get(uri)
      addresses = JSON.parse(response)
      addresses.each do |email|
        @log.notification_settings[:recipients] << email
      end
    end
    timestamp = Time.now.strftime("%m/%d/%y %l:%M%P")
    mail(to: @log.notification_settings[:recipients],
         subject: "#{@log.notification_settings[:subject]} (#{timestamp})")
  end

end
