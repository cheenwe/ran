Rails.application.routes.draw do
  root to: "hello_world#index"

  devise_for :user, controllers: {
        sessions: 'user/sessions',
        registrations: 'user/registrations'
      }

  get 'hello_world', to: 'hello_world#index'



    resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
