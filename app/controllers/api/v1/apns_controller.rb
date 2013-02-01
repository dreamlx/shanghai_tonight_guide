#coding: utf-8
class Api::V1::ApnsController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json

  def create
    init_apns
    apns_messages = params[:message]
    device_token = params[:device_token]
    if apns_messages and device_token
      badge_count = device.badge_count||0
      device.update_attributes(:badge_count => badge_count+1)
      APNS.send_notification(device_token, :alert => apns_messages, :sound => 'default', :badge=>badge_count))
      render :status => 200, :json => { :response => "sent message", :device_token => device_token, :messages =>apns_messages }.to_json  
    else
      render :status =>403, :json =>{:errors =>"message or device_token is null"}
    end
  end
  

end

