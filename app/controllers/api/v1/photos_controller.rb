#coding: utf-8
class Api::V1::PhotosController < ApplicationController
  before_filter :verify_authenticity_token
  respond_to :json
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    album = user.albums.find(params[:album_id])
    if album
      @items = album.photos.page(params[:page])

      render :json=>{:response => 'ok',:message => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }
    else
      render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
    end
  end

  def new
    render :nothing, :status => 403
  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])
    album = user.albums.find(params[:album_id])
    if album
      @photo = Photo.new(params[:photo])
      @photo.album_id = album.id
      @photo.save 
      render :json => { :response => 'ok', :photo=>@photo}.to_json, :status => :ok      
    else
      render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
    end

    #render :nothing, :status => 403
  end

  def show
    user = User.find_by_authentication_token(params[:auth_token])
    album = user.albums.find(params[:album_id])
    if album
      @photo = album.photos.find(params[:id])
      render :json=>{:response => 'ok',:message => 'get one record',:result=>@photo}
    else
      render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
    end      

  end


  def destroy
    user = User.find_by_authentication_token(params[:auth_token])
    album = user.albums.find(params[:album_id])
    if album
      @photo = album.photos.find(params[:id])
      @photo.destroy
      render :json=>{:response => 'ok',:message => 'successfully  deleted'}
    else
      render :json=>{:response => 'failed',:message => 'your album does not exist?'}, :status => 404
    end    

      #render :nothing, :status => 403
  end
end