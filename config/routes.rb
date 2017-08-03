Rails.application.routes.draw do
  resources :subscriptions, only: [:new, :create]

  resource :sessions, only: [:new, :create, :destroy]

  root 'subscriptions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
