# coding: utf-8
class Api::V1::OrdersController < ApplicationController
  respond_to :json
  def index
    sql_query_str = "" 
    sql_query_str += "and place_id = #{params[:place_id]}" unless params[:place_id].blank?
    sql_query_final_str = sql_query_str.sub("and","") #sub 替换第一个，gsub替换全部
    @items = Order.where(sql_query_str).page(params[:page])
    
    render :status => 200, :json=>{:response => 'ok',
      :result => @items, 
      :last_page => @items.num_pages, 
      :current_page => params[:page].to_i
    }
  end
  
  def create
    @item = Order.new(params[:order])
    if @item.save
      render :json => { :response => 'ok', :result => @item}, :status => 200    
    else
      render :status => 403, :json =>{:error =>  @item.errors.messages}
    end  
    #render :nothing, :status => 403
  end
  
  def show
    @order = Order.find(params[:id])
    render :json => { :response => 'ok', :result => @order}, :status => 200    
  end
  
  def update
    @order = Order.find(params[:id])

      if @order.update_attributes(params[:order])
        render :json => { :response => 'ok', :result => @order}, :status => 200    
      else
        render :status => 403, :json =>{:error =>  @order.errors.messages}
      end

  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      render :status => 200, :json =>{:response => "deleted"}
    else
      render :status => 403, :json =>{:error => @order.errors}
    end
  end
end
