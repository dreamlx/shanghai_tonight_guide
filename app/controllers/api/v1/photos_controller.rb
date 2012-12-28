#coding: utf-8
class Api::V1::PhotosController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json

  def create
    user = User.find_by_authentication_token(params[:auth_token])

    case params[:album].downcase

    when "place"
      place = Place.find(params[:place_id])
      @photo = place.photos.new(params[:photo])
      if @photo.save 
        render :json => { :response => 'uploaded a photo', :photo=>@photo}.to_json, :status => 200     
      else
        render :json => { :error => 'upload failed'}.to_json, :status => 403    
      end
    else
      render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404
    end

  end


  def destroy
    user = User.find_by_authentication_token(params[:auth_token])

    case params[:album].downcase    
         
    when "place"
      place = Place.find(params[:place_id])
      photo = place.photos.find(params[:id])
      photo.destroy
     
      render :json=>{:response => 'ok',:message => 'successfully  deleted'}, :status => 200          
        
      #render :nothing, :status => 403
    end
  end