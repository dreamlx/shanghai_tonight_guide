#coding: utf-8
class Api::V1::CitiesController < ApplicationController
	#before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = City.order(:name).page(params[:page])

    render :status=>200, :json=>{:response => 'got cities list',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}  
  end

end