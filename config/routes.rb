Rails.application.routes.draw do
  resources :entries
  root "factories#index"

  resources :factories do
    resources :containers do 
      resources :entries
    end
  end
end
