class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def chiller_off_warning
    @log = params[:log]
    mail(to: ['5138140536@vtext.com',
              '5132849588@vtext.com',
              '5135689345@txt.att.net',
              'vmsforemen@gmail.com'],
         subject: 'Chiller: Not Running When Expected')
  end

  def chiller_on_warning
    @log = params[:log]
    mail(to: ['5138140536@vtext.com',
              '5132849588@vtext.com',
              '5135689345@txt.att.net',
              'vmsforemen@gmail.com'],
         subject: 'Chiller: Running When Not Expected')
  end

  def acid_silo_solution_low
    @log = params[:log]
    mail(to: ['rich.branson@varland.com'],
         subject: 'Acid Silo: Solution Low')
  end
 
  def dichromate_scheduled_temp_control
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Turned on Dichromate Temp Control')
  end
 
  def dichromate_no_temp_control
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Load Into Dichromate w/o Temp Control')
  end
 
  def dichromate_reclaim_sump_solution_high
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Reclaim Sump Solution Level High')
  end
 
  def dichromate_rinse_holding_solution_high
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Rinse Holding Tank Solution Level High')
  end
 
  def dichromate_solution_high
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Solution Level High')
  end
 
  def dichromate_solution_low
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Solution Level Low')
  end
 
  def dichromate_temp_control_disabled
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Temp Control Disabled')
  end
 
  def dichromate_temperature_high
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Tank Temperature High')
  end
 
  def dichromate_temperature_low
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Tank Temperature Low')
  end
 
  def dichromate_temperature_open_circuit
    @log = params[:log]
    mail(to: ['vmsforemen@gmail.com'],
         subject: 'Dichromate: Dichromate Tank Temperature Open Circuit')
  end

end
