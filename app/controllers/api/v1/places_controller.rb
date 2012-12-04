#coding: utf-8
class Api::V1::PlacesController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    @items = Place.order(:name).page(params[:page])

    render :json=>{:response => 'ok',:message => 'get all records',
      :result => @items, :last_page => @items.num_pages, 
      :current_page => params[:page].to_i
    }
  end

  def search
    sql_query_str = ""
    if params[:area_id]
      sql_query_str = sql_query_str+"and area_id = #{params[:area_id]} "
    end
    if params[:category_id]
      sql_query_str = sql_query_str+"and category_id = #{params[:category_id]} "
    end    
    if params[:phone]
      sql_query_str = sql_query_str+"and phone like '#{params[:phone]}' "      
    end
    if params[:name]
      sql_query_str = sql_query_str+"and name like '#{params[:name]}' "         
    end
    if params[:min_price]
      sql_query_str = sql_query_str+"and price > #{params[:min_price]} "         
    end    
    if params[:max_price]
      sql_query_str = sql_query_str+"and price < #{params[:max_price]} "           
    end

    if !sql_query_str.empty?
      sql_query_final_str = sql_query_str.sub("and","")

      @items = Place.where(sql_query_final_str).page(params[:page])

      render :json=>{:response => 'ok',:message => 'get all searched records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }
    else
      render :json=>{:response => 'failed',:message => 'query condition is empty?'}, :status => 404
    end

    
  end

  def new
  	render :nothing, :status => 403
  end
  def create
    @place = Place.new(params[:place])
    @place.save
    render :json => { :response => 'ok', :place=>@place}.to_json, :status => :ok      
  	#render :nothing, :status => 403
  end

  def show
  	@item = Place.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@item}
  end

    def update
      @place = Place.find(params[:id])
      if @place.update_attributes(params[:place])
        render :status=>:ok, :json => {:response => "ok",:message => 'successfully updated place',:place=>@place}
      else
        render :status=>401, :json => {:error => "update failed"}.to_json
      end
    end

  def destroy
  	render :nothing, :status => 403
  end
end