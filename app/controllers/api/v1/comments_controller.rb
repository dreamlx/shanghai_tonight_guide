#coding: utf-8
class Api::V1::CommentsController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index

    place = Place.find(params[:place_id])
    if place
      @items = place.comments.page(params[:page])

      render :json=>{:response => 'ok',:message => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }
    else
      render :json=>{:response => 'failed',:message => 'place does not exist?'}, :status => 404
    end
  end

  def new
  	render :nothing, :status => 403
  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])
    place = Place.find(params[:place_id])
    if place
      @comment = place.comments.new(params[:comment])
      @comment.user_id = user.id
      @comment.save 
      render :json => { :response => 'ok', :comment=>@comment}.to_json, :status => :ok      
    else
      render :json=>{:response => 'failed',:message => 'place does not exist?'}, :status => 404
    end

  	#render :nothing, :status => 403
  end

  def comment_add
    user = User.find_by_authentication_token(params[:auth_token])
    parent_comment = Comment.find(params[:id])
    if parent_comment
      @comment = parent_comment.comments.new(params[:comment])
      @comment.user_id = user.id
      @comment.save 
      render :json => { :response => 'ok', :comment=>@comment}.to_json, :status => :ok      
    else
      render :json=>{:response => 'failed',:message => 'parent comment does not exist?'}, :status => 404
    end    
  end

  def show
  	  @comment = Comment.find(params[:id])
    render :json=>{:response => 'ok',:message => 'get one record',:result=>@comment}
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :json=>{:response => 'ok',:message => 'successfully  deleted'}
  	  #render :nothing, :status => 403
  end
end