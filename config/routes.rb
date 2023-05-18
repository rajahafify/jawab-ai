Rails.application.routes.draw do
  root "factories#index"

  resources :factories do
    resources :containers
  end
end
