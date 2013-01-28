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
end