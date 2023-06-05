Rails.application.routes.draw do
  devise_for :users

  root "factories#index"

  resources :factories do
    resources :containers do 
      resources :entries
    end
  end
end
