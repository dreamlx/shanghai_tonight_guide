class ApplicationController < ActionController::Base
  protect_from_forgery
<<<<<<< HEAD
=======
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :error => exception.message
  end
>>>>>>> new Rails app generated by Rails Apps Composer gem
end
