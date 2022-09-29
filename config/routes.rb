Rails.application.routes.draw do
  get 'static_pages/message'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root "guests#index"
  resources :guests, except: [:show]
end
