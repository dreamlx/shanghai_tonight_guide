#coding: utf-8
class Api::V1::AvatarsController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json

  def create
    u = User.find_by_authentication_token(params[:auth_token])
    u.avatar = params[:avatar]
    u.save!
    
    render :json => { :response => 'uploaded avatar', :user => u }.to_json, :status => 200     
  end
end