class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
  def verify_authenticity_token
  	token_user = User.find_by_authentication_token(params[:auth_token])
  	if token_user.nil? or params[:auth_token].blank?
  	render :status=>404, :json => {:message=>"Invalid token"}.to_json
  end
  end
end
