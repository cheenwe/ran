Rails.application.routes.draw do
  devise_for :users, controllers: {
          sessions: 'users/sessions'
        }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount PgHero::Engine, at: "pghero"


  namespace :admin do
    root to: 'users#index', as: 'root'
    resources :users
  end


end
