class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to   :html,:json, :xml
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    respond_with @users
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

end
