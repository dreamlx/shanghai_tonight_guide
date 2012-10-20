class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  def index
    @users = User.all
  end
  
  def route_map
    @route_map = `rake routes`
  end
end
