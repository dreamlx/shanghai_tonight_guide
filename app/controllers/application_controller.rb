class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
  def verify_authenticity_token
    token_user = User.find_by_authentication_token(params[:auth_token])
    if token_user.nil? or params[:auth_token].blank? or !user_signed_in?
      render :status=>404, :json => {:error => "Invalid token"}.to_json
    end
  end
end
