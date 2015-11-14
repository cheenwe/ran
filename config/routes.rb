Rails.application.routes.draw do

  get '/login', :to => 'sessions#new', :as => 'login'
  delete '/logout', :to => 'sessions#destroy'
  get '/register', :to => 'register#new'

  scope "/:locale" do
    resources :sessions, :only => [:new, :create, :destroy]

    resources :register, :only => [:new, :create, :edit, :update]
    resources :password_reset, :except => [:index, :show, :destroy]

    resources :users
  end
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end


  get '/:locale' => 'users#index'
  root :to => "users#index"

end
