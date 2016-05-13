Rails.application.routes.draw do
  resources :posts
  root 'users#index'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users, :only => [:new, :create, :show]
  resources :sessions, :only => [:create]

  resources :collections, :only => [:index, :new, :create, :edit, :update, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
