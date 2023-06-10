require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  
  devise_for :users

  root "chats#index"

  resources :chats, only: %i[create show destroy] do
    resources :messages, only: %i[create]
  end
end
