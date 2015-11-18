Rails.application.routes.draw do
  mount RuCaptcha::Engine => "/rucaptcha"

  get '/login', :to => 'session#new', :as => 'login'
  delete '/logout', :to => 'session#destroy'
  get '/register', :to => 'register#new'

    resources :session, :only => [:new, :create, :destroy]

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
