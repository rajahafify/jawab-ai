require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  
  devise_for :users

  root "pages#home"

  resources :chats do
    resources :messages, only: :create

    resources :data_sources, only: [:show, :destroy]
    namespace :data_sources do
      resources :texts
      resources :question_answers
    end
  end
end
