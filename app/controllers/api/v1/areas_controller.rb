#coding: utf-8
class Api::V1::CitiesController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = City.order(:name).page(params[:page])

    render :json=>{:response => 'ok',:message => 'get all records',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}
  
  end

  def new
  	render :nothing, :status => 403
  end
  def create
  	render :nothing, :status => 403
  end

  def show
  	@item = City.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@item}
  end

  def destroy
  	render :nothing, :status => 403
  end
end