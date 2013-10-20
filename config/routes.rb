IPark::Application.routes.draw do
  resources :spots, only: [:new, :create, :show, :index, :update, :destroy]

  resources :reservations, only: [:update]

  get "spot/find" => "spots#find"

  get "signup" => "users#new", :as => :new_user
  post "signup" => "users#create", :as => :signup_user
  get "login" => "sessions#new", :as => :new_session
  post "login" => "sessions#create", :as => :login_session
  get "logout" => "sessions#destroy", :as => :logout_session

  root :to => 'spots#index'
end
