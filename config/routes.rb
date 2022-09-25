Rails.application.routes.draw do
  root "guests#index"
  resources :guests, except: [:show]
end
