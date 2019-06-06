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
    log_details = JSON.parse(params[:data])
    log_details.symbolize_keys!
    case @controller.name
    when "Ovens"
      case log_details[:type]
      when 'ro_level_low'
        log = Opto::ROLevelLow.parse(@controller, log_details)
      when 'ro_level_high'
        log = Opto::ROLevelHigh.parse(@controller, log_details)
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
