Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :conversations, only: [:create] do
    member do
      post :close
    end
  end
end
