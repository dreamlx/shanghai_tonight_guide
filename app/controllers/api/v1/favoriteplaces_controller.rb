#coding: utf-8
class Api::V1::FavoriteplacesController < ApplicationController
	before_filter :verify_authenticity_token
	respond_to :json
  def index
    user = User.find_by_authentication_token(params[:auth_token])
    @items = Place.where(:id=>user.favorite_place_ids).order(:name).page(params[:page])


      render :json=>{:response => 'ok',:message => 'get all records',
        :result => @items, :last_page => @items.num_pages, 
        :current_page => params[:page].to_i
      }

  end

  def edit
  	render :nothing, :status => 403
  end

  def update
      user = User.find_by_authentication_token(params[:auth_token])
      @place = Place.find(params[:id])
    if user.favorite_place_ids
      if user.favorite_place_ids.include? (params[:id].to_i) 
        render :json => { :response => 'error',:message => "you already favorite this place"} 
        return 
      end
      new_favorite_place_ids = user.favorite_place_ids.push(params[:id].to_i)
      
      user.update_attribute(:favorite_place_ids, new_favorite_place_ids)
    else
      new_favorite_place_ids = [].push(params[:id].to_i)
      user.favorite_place_ids = new_favorite_place_ids
      user.save
    end 

      render :json => { :response => 'ok',:place => @place}.to_json, :status => :ok      

  	#render :nothing, :status => 403
  end




  def destroy
    user = User.find_by_authentication_token(params[:auth_token]) 

    @place = Place.find(params[:id])
    new_favorite_place_ids = user.favorite_place_ids
    if new_favorite_place_ids.delete(params[:id].to_i).nil?
        render :json => { :response => 'error',:message => "you did not favorite this place yet"} 
        return 
    end

    user.update_attribute(:favorite_place_ids, new_favorite_place_ids)    

    render :json=>{:response => 'ok',:message => 'successfully removed favorite',:place => @place}.to_json, :status => :ok     
  	  #render :nothing, :status => 403
  end
end