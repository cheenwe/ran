Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ## sidekiq route
  require 'sidekiq/web'
  # authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  # end

end
