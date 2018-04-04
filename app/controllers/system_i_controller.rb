class SystemIController < ApplicationController

  skip_before_action  :authenticate_user
  skip_before_action  :verify_authenticity_token

  def update_user
    return head(:internal_server_error) if params[:data].blank?
    user_details = JSON.parse params[:data]
    user_details.symbolize_keys!
    user = User.find_or_create_by(employee_number: user_details[:employee_number])
    return head(:internal_server_error) if user.nil?
    user.first_name = user_details[:first_name]
    user.middle_initial = user_details[:initial]
    user.last_name = user_details[:last_name]
    user.suffix = user_details[:suffix]
    user.username = user_details[:username]
    user.email = user_details[:email]
    user.nickname = user_details[:nickname]
    if user.save
      return head(:ok)
    else
      return head(:internal_server_error)
    end
  end

end
