#coding: utf-8
class Api::V1::AreasController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = Area.order(:name).page(params[:page])

    render :json=>{:response => 'ok',:message => 'get all records',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}
  
  end

  def new
  	render :nothing, :status => 403
  end
  def create
  	render :nothing, :status => 403
  end

  def show
  	@item = Area.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@item}
  end

  def destroy
  	render :nothing, :status => 403
  end
end