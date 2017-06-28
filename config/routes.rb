Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :conversations, only: [:create, :new, :show] do
    member do
      post :close
      post :decline
      post :accept
    end

    resources :messages, only: [:create]

  end

  get "/messages/new", to: "messages#new"
  post "/messages/sent", to: "messages#sent"
end
