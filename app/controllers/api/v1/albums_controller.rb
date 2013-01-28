#coding: utf-8
class Api::V1::AlbumsController < ApplicationController
	#before_filter :verify_authenticity_token
	respond_to :json
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    @items = user.albums.page(params[:page])


      render :json=>{:response => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
        }, :status => 200

  end

  def new
  	render :nothing, :status => 403
  end

  def create
      user = User.find_by_authentication_token(params[:auth_token])

      @album = Album.new(params[:album])
      @album.user_id = user.id
      @album.save 
      render :json => { :response => 'album created', :album=>@album}.to_json, :status => :200

  	#render :nothing, :status => 403
  end

  def show
    user = User.find_by_authentication_token(params[:auth_token])
    @album = user.albums.find(params[:id])  

    render :json=>{:response => 'ok', :result=>@album}, :status => 200
  end


  def destroy
    user = User.find_by_authentication_token(params[:auth_token])    
    album = user.albums.find(params[:id])
    album.destroy
    render :json=>{:response => 'successfully  deleted'}, :status => 200
  	  #render :nothing, :status => 403
  end
end