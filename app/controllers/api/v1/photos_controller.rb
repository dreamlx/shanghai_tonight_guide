#coding: utf-8
class Api::V1::PhotosController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    if !params[:bl].nil?
      case params[:bl].downcase
      when "album"    
        album = user.albums.find(params[:id])
        if album
          @items = album.photos.page(params[:page])

          render :json=>{:response => 'ok',:message => 'get all records',
            :result => @items, :last_page => @items.num_pages, 
            :current_page => params[:page].to_i
          }
        else
          render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
        end
      when "place"
        place = Place.find(params[:id])
        @items = place.photos.page(params[:page])

        render :json=>{:response => 'ok',:message => 'get all records',
          :result => @items, :last_page => @items.num_pages, 
          :current_page => params[:page].to_i
        }        
      else
        render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404
      end
    else
      render :json=>{:response => 'failed',:message => 'param bl is nil ? it should be Album or Place'}, :status => 404
    end
  end

  def new
    render :nothing, :status => 403
  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])
    if !params[:bl].nil?
      case params[:bl].downcase
      when "album"
        album = user.albums.find(params[:id])
        if album
          @photo = album.photos.new(params[:photo])
          @photo.save 
          render :json => { :response => 'ok', :photo=>@photo}.to_json, :status => :ok      
        else
          render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
        end
      when "place"
          place = Place.find(params[:id])
          @photo = place.photos.new(params[:photo])
          @photo.save 
          render :json => { :response => 'ok', :photo=>@photo}.to_json, :status => :ok      
       
      else
          render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404
      end
    else
      render :json=>{:response => 'failed',:message => 'param bl is nil ? it should be Album or Place'}, :status => 404
    end

    #render :nothing, :status => 403
  end

  def show
    user = User.find_by_authentication_token(params[:auth_token])
    if !params[:bl].nil?
      case params[:bl].downcase
      when "album"    
        begin 
          album = user.albums.find(params[:bl_id])
        rescue ActiveRecord::RecordNotFound
          album = nil
        end
        if album
          @photo = album.photos.find(params[:id])
          render :json=>{:response => 'ok',:message => 'get one record',:result=>@photo}
        else
          render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
        end
      when "place"
        begin 
          place = Place.find(params[:bl_id])
        rescue ActiveRecord::RecordNotFound
          place = nil
        end        
        if place
          @photo = place.photos.find(params[:id])
          render :json=>{:response => 'ok',:message => 'get one record',:result=>@photo}
        else 
          render :json=>{:response => 'failed',:message => 'place does not exist?'}, :status => 404
        end
      else
        render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404        
      end     
    else
      render :json=>{:response => 'failed',:message => 'param bl is nil ? it should be Album or Place'}, :status => 404
    end      

  end


  def destroy
    user = User.find_by_authentication_token(params[:auth_token])
    if !params[:bl].nil?
      case params[:bl].downcase    
      when "album"
        album = user.albums.find(params[:bl_id])
        if album
          photo = album.photos.find(params[:id])
          photo.destroy
          render :json=>{:response => 'ok',:message => 'successfully  deleted'}
        else
          render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
        end            
      when "place"
        place = Place.find(params[:bl_id])
        if place
          begin
            photo = place.photos.find(params[:id])
            photo.destroy
            render :json=>{:response => 'ok',:message => 'successfully  deleted'}           
          rescue ActiveRecord::RecordNotFound
            photo = nil
            render :json=>{:response => 'failed',:message => 'photo does not exist?'}
          end   
          
        else
          render :json=>{:response => 'failed',:message => 'place does not exist?'}, :status => 404          
        end
      else
        render :json=>{:response => 'failed',:message => 'the photo belongs to what model? Album or Place'}, :status => 404        
      end      
    else
      render :json=>{:response => 'failed',:message => 'param bl is nil ? it should be Album or Place'}, :status => 404
    end          


      #render :nothing, :status => 403
  end
end