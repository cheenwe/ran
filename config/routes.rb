Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "users#index"

  mount PgHero::Engine, at: "pghero"

  devise_for :users, path: 'account', controllers: {
    login: 'users/sessions',
    logout: 'users/sessions#sign_out',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # get '/auth/:provider/callback', to: 'sessions#create'
  match 'dashboard', to: 'users#dashboard', via: [:get, :post]

  match 'icons', to: 'page#icons', via: [:get]

  resources :users
end
