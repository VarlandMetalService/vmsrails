class OptoController < ApplicationController

  skip_before_action  :authenticate_user
  skip_before_action  :verify_authenticity_token

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
    log_details = JSON.parse(params[:data], symbolize_names: true)
    if log_details[:controller_ip].present?
      @controller = Opto::Controller.find_by(ip_address: log_details[:controller_ip])
    else
      @controller = Opto::Controller.find_by(ip_address: request.remote_ip)
    end
    return head(:internal_server_error) if @controller.blank?
    begin
      log_class = "opto/#{log_details[:type]}".camelize.constantize
    rescue NameError
      log_class = Opto::GenericOptoLog
    end
    log = log_class.parse(@controller, log_details)
    if log.save
      return head(:ok)
    else
      return head(:internal_server_error)
    end
  end

end
