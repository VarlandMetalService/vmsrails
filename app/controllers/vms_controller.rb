class VmsController < ApplicationController

  def home
    [:primary, :secondary, :success, :danger, :warning, :info, :light, :dark].each do |type|
      #flash.now[type] = "#{type}"
    end
  end
  
end
