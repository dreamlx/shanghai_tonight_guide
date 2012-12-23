#coding: utf-8
class Api::V1::ProvincesController < ApplicationController
	#before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = Province.order(:name).page(params[:page])

    render :status=>200, :json=>{:response => 'got provinces list',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}
  
  end

end