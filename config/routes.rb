Rails.application.routes.draw do
  root to: 'home#index'

  resources :subscribers, only: [:create]

  namespace :admin do
    root to: 'base#index'
    resources :prizes
  end
end
