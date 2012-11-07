#coding: utf-8
class Api::V1::UsersController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = User.page(params[:page])

    render :json=>{:response => 'ok',:message => 'get all records',
      :result => @items, :last_page => @items.num_pages, 
      :current_page => params[:page].to_i
    }
  end

  def new
  	render :nothing, :status => 403
  end
  def create
    @user = User.new(params[:user])
    @user.save
    render :json => { :response => 'ok', :user=>@user}.to_json, :status => :ok      
  	#render :nothing, :status => 403
  end

  def show
  	  @item = User.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@item}
  end

  def edit
    @user = User.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@user}
  end

  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        render :status=>:ok, :json => {:response => "ok",:message => 'successfully updated user',:user=>@user}
      else
        render :status=>401, :json => {:error => "update failed"}.to_json
      end
  end

  def destroy
  	render :nothing, :status => 403
  end
end