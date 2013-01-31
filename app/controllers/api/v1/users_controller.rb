#coding: utf-8
class Api::V1::UsersController < ApplicationController
  before_filter :verify_authenticity_token,:except =>[:new, :create]
  respond_to :json
  def index
    @items = User.page(params[:page])

    render :status=>200, :json=>{:response => 'got user list',
      :result => @items, :last_page => @items.num_pages, 
      :current_page => params[:page].to_i
    }
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render :status=>200,:json => { :response => 'created user', :user=>@user}.to_json 
    else
      render :status=>403,:json => { :error => 'creat user failed'}.to_json
    end
    #render :nothing, :status => 403
  end

  def show
    @item = User.find(params[:id])
    render :status=>200,:json=>{:response => 'got user',:result=>@item}.to_json
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :status=>200, :json => {:response => 'successfully updated user',:user=>@user}
    else
      render :status=>403, :json => {:error => @user.errors.messages}.to_json
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render :status=>200, :json => {:response => "successfully deleted user"}.to_json

  end
end