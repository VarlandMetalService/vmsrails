class OptoController < ApplicationController

  skip_before_action  :authenticate_user
  skip_before_action  :verify_authenticity_token
  before_action :load_controller,
                only: :log

  has_scope :sorted_by,
            only: :logs,
            default: nil,
            allow_blank: true
  has_scope :with_timestamp_gte, only: :logs
  has_scope :with_timestamp_lte, only: :logs
  has_scope :with_controller, only: :logs
  has_scope :with_type, only: :logs
  
  def logs
    @logs = apply_scopes(Opto::Log).includes(:controller).page(params[:page])
  end

  def log
    return head(:internal_server_error) if params[:data].blank?
    return head(:internal_server_error) if @controller.blank?
    log_details = JSON.parse(params[:data])
    log_details.symbolize_keys!
    case @controller.name
    when "Ovens"
      case log_details[:type]
      # when 'oven_not_requesting_power'
      #   log = Opto::OvenNotRequestingPower.parse(@controller, log_details)
      # when 'oven_requesting_power_too_high'
      #   log = Opto::OvenRequestingPowerTooHigh.parse(@controller, log_details)
      # when 'oven_temp_too_high'
      #   log = Opto::OvenTooHigh.parse(@controller, log_details)
      # when 'oven_temp_too_low'
      #   log = Opto::OvenTooLow.parse(@controller, log_details)
      # when 'oven_too_high_too_long'
      #   log = Opto::OvenTooHighTooLong.parse(@controller, log_details)
      # when 'oven_too_low_too_long'
      #   log = Opto::OvenTooLowTooLong.parse(@controller, log_details)
      # when 'oven_warmup_too_long'
      #   log = Opto::OvenWarmupTooLong.parse(@controller, log_details)
      # when 'oven_warmup_shutdown'
      #   log = Opto::OvenWarmupShutdown.parse(@controller, log_details)
      # when 'oven_loadings_timeout'
      #   log = Opto::OvenLoadingsTimeout.parse(@controller, log_details)
      # when 'pcr_temp_exceeded_shutdown'
      #   log = Opto::PcrTempExceededShutdown.parse(@controller, log_details)
      # when 'salt_spray_temperature_high'
      #   log = Opto::SaltSprayTemperatureHigh.parse(@controller, log_details)
      # when 'salt_spray_temperature_low'
      #   log = Opto::SaltSprayTemperatureLow.parse(@controller, log_details)
      # when 'display_project_not_responding'
      #   log = Opto::DisplayProjectNotResponding.parse(@controller, log_details)
      when 'bad_oven_probe'
        log = Opto::BadOvenProbe.parse(@controller, log_details)
      # when 'oven_kwh_high_restricted'
      #   log = Opto::OvenKwhHighRestricted.parse(@controller, log_details)
      # when 'oven_air_temp_exceeded'
      #   log = Opto::OvenAirTempExceeded.parse(@controller, log_details)
      # when 'pcr_temp_exceeded'
      #   log = Opto::PcrTempExceeded.parse(@controller, log_details)
      # when 'request_power_not_loaded'
      #   log = Opto::RequestPowerNotLoaded.parse(@controller, log_details)
      # when 'oven_door_open_while_running'
      #   log = Opto::OvenDoorOpenWhileRunning.parse(@controller, log_details)
      # when 'ovens_io_error'
      #   log = Opto::OvensIoError.parse(@controller, log_details)
      # when 'bead_blaster_no_motion'
      #   log = Opto::BeadBlasterNoMotion.parse(@controller, log_details)
      # when 'monthly_high_kwh'
      #   log = Opto::MonthlyHighKwh.parse(@controller, log_details)
      # when 'eom_monthly_high_kwh'
      #   log = Opto::EomMonthlyHighKwh.parse(@controller, log_details)
      # when '3_phase_power_off'
      #   log = Opto::ThreePhasePowerOff.parse(@controller, log_details)
      # when '15_minute_kwh_high'
      #   log = Opto::FifteenMinuteKwhHigh.parse(@controller, log_details)
      when 'ro_city_water_pressure'
        log = Opto::RoCityWaterPressure.parse(@controller, log_details)
      when 'ro_reject_overflow'
        log = Opto::RoRejectOverflow.parse(@controller, log_details)
      when 'ro_storage_tank_overflow'
        log = Opto::RoStorageTankOverflow.parse(@controller, log_details)
      when 'ro_level_low'
        log = Opto::RoLevelLow.parse(@controller, log_details)
      when 'ro_level_high'
        log = Opto::RoLevelHigh.parse(@controller, log_details)
      else
        return head(:internal_server_error)
      end
    when "Chiller"
      case log_details[:type]
      when 'chiller_on_warning'
        log = Opto::ChillerOnWarning.parse(@controller, log_details)
      when 'chiller_off_warning'
        log = Opto::ChillerOffWarning.parse(@controller, log_details)
      else
        return head(:internal_server_error)
      end
    when "Dichromate"
      case log_details[:type]
      when 'acid_silo_solution_low'
        log = Opto::AcidSiloSolutionLow.parse(@controller, log_details)
      when 'scheduled_temp_control'
        log = Opto::DichromateScheduledTempControl.parse(@controller, log_details)
      when 'no_temp_control'
        log = Opto::DichromateNoTempControl.parse(@controller, log_details)
      when 'reclaim_sump_solution_high'
        log = Opto::DichromateReclaimSumpSolutionHigh.parse(@controller, log_details)
      when 'rinse_holding_solution_high'
        log = Opto::DichromateRinseHoldingSolutionHigh.parse(@controller, log_details)
      when 'dichromate_solution_high'
        log = Opto::DichromateSolutionHigh.parse(@controller, log_details)
      when 'dichromate_solution_low'
        log = Opto::DichromateSolutionLow.parse(@controller, log_details)
      when 'temp_control_disabled'
        log = Opto::DichromateTemperatureControlDisabled.parse(@controller, log_details)
      when 'dichromate_temp_high'
        log = Opto::DichromateTemperatureHigh.parse(@controller, log_details)
      when 'dichromate_temp_low'
        log = Opto::DichromateTemperatureLow.parse(@controller, log_details)
      when 'dichromate_temp_open'
        log = Opto::DichromateTemperatureOpenCircuit.parse(@controller, log_details)
      else
        return head(:internal_server_error)
      end
    else
      return head(:internal_server_error)
    end
    if log.save
      return head(:ok)
    else
      return head(:internal_server_error)
    end
  end

private

  def load_controller
    @controller = Opto::Controller.find_by(ip_address: request.remote_ip)
  end

end
