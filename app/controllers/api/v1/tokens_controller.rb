# coding: utf-8
class Api::V1::TokensController  < ApplicationController
  #skip_before_filter :verify_authenticity_token
  respond_to :json
  def index
    render :json => {:name => "David"}.to_json
  end
      
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    nickname = params[:user][:name]
    if request.format != :json
      render :status=>406, :json=>{:error=>"The request must be json"}
      return
    end
	 
    if email.nil? or password.nil?
      render :status=>400,
      :json=>{:error=>"The request must contain the user email and password."}
      return
    end
	 
    @user=User.find_by_email(email.downcase)
	 
    if @user.nil?
      #logger.info("User #{email} failed signin, user cannot be found.")
      render :status=>401, :json=>{:error=>"Invalid email or passoword."}
      return
    end
	 
    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
    @user.ensure_authentication_token!
	 
    if not @user.valid_password?(password)
      #logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:error=>"Invalid email or password."}
    else
      render :json => { :response => 'ok', :user=>@user,:auth_token => @user.authentication_token }.to_json, :status => :ok	
      #render :status=>200, :json=>{:token=>@user.authentication_token}
    end
  end
	 
  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      #logger.info(“Token not found.”)
      render :status=>404, :json => {:error=>"Invalid token"}.to_json
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}.to_json
    end
  end
	 
end