#coding: utf-8
class Api::V1::PhotosController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json
  
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    case params[:album].downcase

    when "place"
      place = Place.find(params[:place_id])
      @items = place.photos.page(params[:page])

      render :json=>{:response => 'ok',:message => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }        
    else
      render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404
    end

  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])

    case params[:album].downcase
    when "place"
      place = Place.find(params[:place_id])
      @photo = place.photos.new(params[:photo])
      if @photo.save 
        render :json => { :response => 'uploaded a photo', :photo=>@photo}.to_json, :status => 200     
      else
        render :json => { :error => @photo.errors}.to_json, :status => 403    
      end
    else
      render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404
    end

  end

  def show
    @photo = Photo.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get all records',
      :result => @photo
      }, :status => 200
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
  end