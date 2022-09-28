Rails.application.routes.draw do
  devise_for :users
  root "guests#index"
  resources :guests, except: [:show]
end
