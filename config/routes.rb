Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :qingting do
        resources :programs
      end
    end
  end
  resources :queries
	mount RuCaptcha::Engine => "/rucaptcha"

	get '/login', :to => 'session#new', :as => 'login'
	delete '/logout', :to => 'session#destroy'
	get '/register', :to => 'register#new'
	get 'dashboard/v1'

	resources :session, :only => [:new, :create, :destroy]
	resources :register, :only => [:new, :create, :edit]
	resources :password_reset, :only =>  [:new, :create, :edit, :update]

	resources :users

	root  :to => 'dashboard#v1'

	get 'plugs/icons'
	get 'plugs/animations'
	get 'plugs/animations'


	get 'plugs/icons'
	get 'plugs/animations'
	get 'plugs/colors'

       #-----------------for api

	namespace :api do
		namespace :v1 do
			resources :users
			resources :qingting
			resources :schedule

		end
	end

end
