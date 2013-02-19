# coding: utf-8
class Api::V1::ReportsController < ApplicationController
  respond_to :json
  def index
    sql_query_str = "" 
    sql_query_str += "and place_id = #{params[:place_id]}" unless params[:place_id].blank?
    sql_query_str += "and use_id = #{params[:use_id]}" unless params[:user_id].blank?
    
    sql_query_final_str = sql_query_str.sub("and","") #sub 替换第一个，gsub替换全部
    @items = Report.where(sql_query_str).page(params[:page])
    
    render :status => 200, :json=>{:response => 'ok',
      :result => @items, 
      :last_page => @items.num_pages, 
      :current_page => params[:page].to_i
    }
  end
  
  def create
    @report = Report.new(params[:report])
    if @report.save
      render :json => { :response => 'ok', :result => @report}, :status => 200    
    else
      render :status => 403, :json =>{:error =>  @report.errors.messages}
    end  
    #render :nothing, :status => 403
  end
  
  def show
    @item = Report.find(params[:id])
    render :json => { :response => 'ok', :result => @item}, :status => 200    
  end
  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @item = Report.find(params[:id])
    if @item.destroy
      render :status => 200, :json =>{:response => "deleted"}
    else
      render :status => 403, :json =>{:error => @item.errors}
    end
  end
end
