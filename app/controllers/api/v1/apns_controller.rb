#coding: utf-8
class Api::V1::ApnsController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json

  def create
    init_apns
    apns_messages = params[:message]
    device_token = params[:device_token]
    
    APNS.send_notification(device_token, apns_messages)
    render :status => 200, :json => { :response => "sent message", :device_token => device_token, :messages =>apns_messages }.to_json  
  end
end

