require 'net/http'
require 'uri'

class QueriesController < ApplicationController

  skip_before_action  :authenticate_user,
                      only: [:promise_list, :receipts, :prop65]
  before_action :reference_user,
                only: [:promise_list, :receipts, :prop65]

  def prop65
    if params[:customer].blank?
      @customer = nil
    else
      uri = URI.parse "http://as400railsapi.varland.com/v1/prop65customer?customer=#{params[:customer]}"
      http = Net::HTTP.new uri.host, uri.port
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request request
      @customer = JSON.parse response.body, symbolize_names: true
      respond_to do |format|
        format.html
        format.js
        format.xlsx
      end
    end
  end
  
  def receipts
    uri = URI.parse 'http://as400railsapi.varland.com/v1/receipts'
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request
    @receipts = JSON.parse response.body
    @receipts.each do |r|
      r.symbolize_keys!
    end
    remove_nav_xs
    auto_refresh 60
  end
  
  def promise_list
    @dates = Hash.new
    uri = URI.parse 'http://as400railsapi.varland.com/v1/promise_list'
    http = Net::HTTP.new uri.host, uri.port
    request = Net::HTTP::Get.new uri.request_uri
    response = http.request request
    @promised_jobs = JSON.parse response.body
    @promised_jobs.each do |j|
      j.symbolize_keys!
      promise_date = Date.strptime(j[:promise_date].to_s, '%s')
      key = promise_date.strftime '%m/%d/%Y (%a)'
      date_class = 'primary'
      if promise_date == Date.today
        key = 'Today'
        date_class = 'success'
      end
      if promise_date < Date.today
        date_class = 'danger'
      end
      key = 'Tomorrow' if promise_date == Date.tomorrow
      @dates[key] = { class: date_class, jobs: Array.new } unless @dates.key? key
      @dates[key][:jobs] << j
    end
    @dates.symbolize_keys!
    remove_nav_xs
  end

end
