Rails3BootstrapDeviseCancan::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :places

  resources :categories

  resources :provinces

  resources :cities

  resources :areas

  resources :albums

  resources :photos

  #authenticated :user do
  #	root :to => 'home#index'
  #end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]

  namespace :api do
    namespace :v1 do
      
      resources :tokens
      
      resources :girls
      
      resources :places do
        collection do
          get 'search'
        end
      end

      resources :categories

      resources :provinces

      resources :cities

      resources :areas

      resources :users    

      resources :albums         

      resources :photos 
      
      resources :avatars        

      resources :comments do
        member do
          post 'comment_add'
        end
      end   

      resources :favoriteplaces      

    end		
  end
  match ':controller(/:action(/:id))(.:format)'
end
