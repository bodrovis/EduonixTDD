Rails.application.routes.draw do
  resources :subscriptions, only: [:new, :create]

  resources :sessions, only: [:new, :create]

  root 'subscriptions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
