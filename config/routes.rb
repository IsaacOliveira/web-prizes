Rails.application.routes.draw do
  root to: 'home#index'

  resources :subscribers, only: [:create]
end
