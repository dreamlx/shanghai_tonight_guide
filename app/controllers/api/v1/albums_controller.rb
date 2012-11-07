#coding: utf-8
class Api::V1::AlbumsController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    @items = user.albums.page(params[:page])


      render :json=>{:response => 'ok',:message => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }

  end

  def new
  	render :nothing, :status => 403
  end

  def create
      user = User.find_by_authentication_token(params[:auth_token])

      @album = Album.new(params[:album])
      @album.user_id = user.id
      @album.save 
      render :json => { :response => 'ok', :album=>@album}.to_json, :status => :ok      

  	#render :nothing, :status => 403
  end

  def show
    user = User.find_by_authentication_token(params[:auth_token])
    @album = user.albums.find(params[:id])  

    render :json=>{:response => 'ok',:message => 'get one record',:result=>@album}
  end


  def destroy
    user = User.find_by_authentication_token(params[:auth_token])    
    @album = user.albums.find(params[:id])
    @album.destroy
    render :json=>{:response => 'ok',:message => 'successfully  deleted'}
  	  #render :nothing, :status => 403
  end
end