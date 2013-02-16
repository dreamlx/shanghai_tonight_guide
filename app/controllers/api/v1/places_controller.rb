#coding: utf-8
class Api::V1::PlacesController < ApplicationController
  #before_filter :verify_authenticity_token
  respond_to :json
  def index
    @items = Place.order(:name).page(params[:page])

    render :status => 200, :json=>{:response => 'get places list',
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
      sql_query_str = sql_query_str+"and name like '%#{params[:name]}%' "         
    end
    if params[:min_price]
      sql_query_str = sql_query_str+"and price > #{params[:min_price]} "         
    end    
    if params[:max_price]
      sql_query_str = sql_query_str+"and price < #{params[:max_price]} "           
    end

    if !sql_query_str.empty?
      sql_query_final_str = sql_query_str.sub("and","") #sub 替换第一个，gsub替换全部

      @items = Place.where(sql_query_final_str).page(params[:page])

      @items.each do |item| 
        @comments = item.comments
        worth =  Comment.get_worth(@comments)
        worthless = Comment.get_worthless(@comments)
        
        item["comment_count"] = item.comments.size
        item["photo_count"] = item.photos.count
        item["worth"] = worth
        item["worthless"] = worthless
        item["order_price"]= item.price
      end
      
      order_name = params[:order_by]
      @items.sort!{|a,b| a["#{order_name}"] <=> b["#{order_name}"]} if params[:order_by]
      render :status => 200, :json=>{:response => 'find places',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }
    else
      render :json=>{:error => 'query condition is empty?'}, :status => 404
    end

    
  end

  def create
    @place = Place.new(params[:place])
    @place.save
    render :json => { :response => 'ok', :place=>@place}.to_json, :status => :ok      
    #render :nothing, :status => 403
  end

  def show
    @item = Place.where("id = ? ",params[:id]).first
    @photos= @item.photos
    @comments = @item.comments
    worth =  Comment.get_worth(@comments)
    worthless = Comment.get_worthless(@comments)
    
    unless @item.blank?
      render :status => 200,:json=>{:response => 'got place',:result=>@item,:photos=> @photos, 
        :comment_count => @comments.size, :worth => worth, :worthless => worthless }
      else
        render :status => 404,:json=>{:error => 'no found'}
      end
    end

    def update
      @place = Place.find(params[:id])
      if @place.update_attributes(params[:place])
        render :status=> 200, :json => {:response =>'successfully updated place',:place=>@place}
      else
        render :status=> 401, :json => {:error => "update failed"}.to_json
      end
    end

    def destroy
      render :nothing, :status => 403
    end
  end