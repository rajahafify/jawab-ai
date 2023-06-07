require 'sidekiq/web'

Rails.application.routes.draw do
  # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "/sidekiq"
  
  devise_for :users

  root "factories#index"

  resources :factories do
    resources :containers do 
      resources :entries
    end
  end

  resources :chats, only: %i[new create show] do
    resources :messages, only: %i[create]
  end
end
