class OptoMailer < ApplicationMailer

  default from: 'varlandmetalservice@gmail.com'
  layout 'opto_mailer'
  helper :opto

  def fifteen_minute_kwh_high
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: 15 Minute KWH High')
  end

  def three_phase_power_off
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: 3 Phase Power Off')
  end

  def eom_monthly_high_kwh
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: EOM KWH High for Previous Month')
  end

  def monthly_high_kwh
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: New KWH High for Month Established')
  end

  def bead_blaster_no_motion
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Bead Blaster Stopped Because No Motion')
  end

  def ovens_io_error
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: I/O Error')
  end

  def oven_door_open_while_running
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Door Opened While Oven Running')
  end

  def request_power_not_loaded
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Stopped Because Requesting Power While Not Loaded')
  end

  def pcr_temp_exceeded
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Power Restricted to Oven Because Temperature Too High for Process Code')
  end

  def oven_air_temp_exceeded
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Power Restricted to Oven Because Air Temperature High')
  end

  def oven_kwh_high_restricted
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Power Restricted to Oven Because KWH High')
  end

  def bad_oven_probe
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Bad Oven Temperature Probe')
  end

  def display_project_not_responding
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Display Project Not Responding')
  end

  def salt_spray_temperature_low
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Salt Spray Cabinet Temperature Low')
  end

  def salt_spray_temperature_high
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Salt Spray Cabinet Temperature High')
  end

  def pcr_temp_exceeded_shutdown
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Stopped Because Temperature Too High for Process Code')
  end

  def oven_loadings_timeout
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Loadings Timed Out, No Longer Holding Temperature')
  end

  def oven_warmup_shutdown
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Stopped Because Warmup Taking Too Long')
  end

  def oven_warmup_too_long
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Warmup Taking Longer Than Expected')
  end

  def oven_too_low_too_long
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Bake Cycle Reset Because Temperature Too Low Too Long')
  end

  def oven_too_high_too_long
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Stopped Because Temperature Too High Too Long')
  end

  def oven_temp_too_low
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Temperature Low')
  end

  def oven_temp_too_high
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Temperature High')
  end

  def oven_requesting_power_too_high
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Requesting Power While Temperature High')
  end

  def oven_not_requesting_power
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: Oven Not Requesting Power During Warmup')
  end

  def ro_city_water_pressure
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com',
              '5134768439@vtext.com'],
         subject: 'Ovens: RO City Water Pressure Problem')
  end

  def ro_reject_overflow
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com',
              '5134768439@vtext.com'],
         subject: 'Ovens: RO Reject Overflow')
  end

  def ro_storage_tank_overflow
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com',
              '5134768439@vtext.com'],
         subject: 'Ovens: RO Storage Tank Overflow')
  end

  def ro_level_low
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: RO Level Low')
  end

  def ro_level_high
    @log = params[:log]
    mail(to: ['8594964920@vtext.com',
              'toby.varland@varland.com'],
         subject: 'Ovens: RO Level High')
  end

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
