#coding: utf-8
class Api::V1::ProvincesController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = Province.all

    render :json=>{:response => 'ok',:message => 'get all records',:result=>@items}
  end

  def new
  	render :nothing, :status => 403
  end
  def create
  	render :nothing, :status => 403
  end

  def show
  	@item = Province.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@item}
  end

  def destroy
  	render :nothing, :status => 403
  end
end