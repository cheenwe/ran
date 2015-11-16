Rails.application.routes.draw do

  get '/login', :to => 'sessions#new', :as => 'login'
  delete '/logout', :to => 'sessions#destroy'
  get '/register', :to => 'register#new'

    resources :sessions, :only => [:new, :create, :destroy]

    resources :register, :only => [:new, :create, :edit, :update]
    resources :password_reset, :only =>  [:new, :create, :edit, :update]

    resources :users

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end


  root :to => "users#index"

end
