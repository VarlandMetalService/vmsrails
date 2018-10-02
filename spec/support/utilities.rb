require 'spec_helper'
include ApplicationHelper

module Utilities
  def login(user)
    @session ||= {}
    @session[:user_id] = nil
    @session[:user_id] = user.id
  end
end