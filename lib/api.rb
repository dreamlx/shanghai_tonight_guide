
module TonightGuide
  class API < Grape::API
    prefix 'api'
    format :json

    get "ping" do
      "pong"
    end

    resource "users" do
      get do
        User.all
      end

      get ":id" do
        User.find(params[:id])
      end
    end
    
  end
end