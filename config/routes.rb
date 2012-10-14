Rails3BootstrapDeviseCancan::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :places

  resources :categories

  resources :provinces

  resources :cities

  resources :areas

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
		end		
	end
end
