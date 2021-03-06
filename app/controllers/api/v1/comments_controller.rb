#coding: utf-8
class Api::V1::CommentsController < ApplicationController
  before_filter :verify_authenticity_token, :except =>[:show]
  respond_to :json
  def index

    place = Place.where("id = ?",params[:place_id]).first
    unless place.nil?
      @items = place.comments.page(params[:page])
      
      @items.map{|item| item.user_name = item.user.name unless item.user.nil?}
      
      render :status => 200, :json=>{:response => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }
    else
      
      render :json=>{:error => 'place does not exist?'}, :status => 404
    end
  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])
    place = Place.find(params[:place_id])
    if place
      @comment = place.comments.new(params[:comment])
      @comment.user_id = user.id||""
      @comment.save 
      render :json => { :response => 'ok', :comment=>@comment, :user => user}.to_json, :status => 200     
    else
      render :json=>{:error => 'failed',:message => 'place does not exist?'}, :status => 404
    end
  end

  def comment_add
    user = User.find_by_authentication_token(params[:auth_token])
    parent_comment = Comment.find(params[:id])
    if parent_comment
      @comment = parent_comment.comments.new(params[:comment])
      @comment.user_id = user.id
      @comment.save 
      render :json => { :response => 'ok', :comment=>@comment}.to_json, :status => 200     
    else
      render :json=>{:error => 'failed',:message => 'parent comment does not exist?'}, :status => 404
    end    
  end

  def show
    @comment = Comment.find(params[:id])
    user = User.find(@comment.user_id)
    render :json=>{:response => 'get one record',:result=>@comment, :user => user}, :status => 200
  end


  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json=>{:response => 'successfully  deleted'}, :status => 200
    else
      render :json=>{:error => 'not found this id'}, :status => 404
    end  
    #render :nothing, :status => 403
  end
end