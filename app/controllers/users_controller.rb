class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    respond_to do |format|   
      format.html   
      format.xml { render :xml => @users }   
      format.json { render :text => @users.to_json }   
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|   
      format.html   
      format.xml { render :xml => @user }   
      format.json { render :text => @user.to_json }   
    end
  end

end
