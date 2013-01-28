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
  
  def init_apns
    #APNS.host = 'gateway.push.apple.com' 
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = Rails.root.to_s + "/public/certification/cert.pem"
    # this is the file you just created
    
    APNS.port = 2195 
    # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.
    # send
  end
end
