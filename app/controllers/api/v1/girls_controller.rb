#coding: utf-8
class Api::V1::GirlsController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
     @items = Girl.order(:name).page(params[:page])

    render :json=>{:response => 'ok',:message => 'get all records',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}
  
  end

  def new
  	@girl = Girl.new
  	render :json=>{:girl=>@girl}
  end
  def create
  	girl = params[:girl]
  	girl.save
  	render :json => { :response => 'ok', :user=>@girl}.to_json, :status => :ok	
  end

  def show
  	girl = Girl.find(params[:id])
  end

  def destroy
  	Girl.find(params[:id]).delete
  end
end