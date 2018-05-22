class OptoController < ApplicationController

  skip_before_action  :authenticate_user
  skip_before_action  :verify_authenticity_token
  before_action :load_controller

  def log
    return head(:internal_server_error) if params[:data].blank?
    log_details = JSON.parse(params[:data])
    log_details.symbolize_keys!
    case @controller.name
    when "Dichromate"
      case log_details[:type]
      when 'dichromate_solution_low'
        log = Opto::DichromateSolutionLow.parse(@controller, log_details)
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
