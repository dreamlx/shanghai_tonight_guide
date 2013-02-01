#coding: utf-8
class Api::V1::DevicesController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json
  def index
    tokens = Device.all
    render :json => { :response => tokens }.to_json, :status => 200     
  end
  
  def create
    token = Device.create(params[:device])
    if token.save
      render :json => { :response => token }.to_json, :status => 200     
    else
      render :json => { :errors => token.errors.full_messages }.to_json, :status => 403
    end
  end
  
  def show
    device_token = params[:device_token]
    token = Device.find_by_device_token(device_token)
    if token
      render :json => { :response => token }.to_json, :status => 200     
    else
      render :json => { :errors => token.errors.full_messages }.to_json, :status => 403
    end
  end
  
  def empty_badge
    device_token = params[:device_token]
    @token = Device.find_by_device_token(device_token)
    
    if @token.update_attributes(:badge_count => 0)
      render :status=>200, :json => {:response => 'successfully updated'}
    else
      render :status=>403, :json => {:error => @token.errors.messages}.to_json
    end
  end
  
end