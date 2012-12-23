#coding: utf-8
class Api::V1::CategoriesController < ApplicationController
	#before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = Category.order(:name).page(params[:page])

    render :status => 200, :json=>{:response => 'get all records',:result => @items, :last_page => @items.num_pages, :current_page => params[:page].to_i}
  
  end

  def new
  	render :nothing, :status => 403
  end
  def create
  	render :nothing, :status => 403
  end

  def show
  	@item = Category.find(params[:id])
    render :status => 200,:json=>{:response => 'got category',:result=>@item}
  end

  def destroy
  	render :nothing, :status => 403
  end
end