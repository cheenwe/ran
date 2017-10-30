Rails.application.routes.draw do
  root to: 'admin/users#index'

  devise_for :users, controllers: {
          sessions: 'users/sessions',
  	  omniauth_callbacks: 'users/omniauth_callbacks'
        }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount PgHero::Engine, at: "pghero"


  namespace :admin do
    root to: 'users#index', as: 'root'
    resources :users
  end

  match 'icons', to: 'page#icons', via: [:get]

end
