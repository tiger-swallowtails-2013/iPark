IPark::Application.routes.draw do
  resources :spots, only: [:new, :create, :show, :index, :update, :destroy]
  resources :users, only: [:show]

  resources :reservations, only: [:update, :destroy, :new, :create]

  get "search/spots" => "spots#search"
  get "search/autocomplete" => "spots#autocomplete"
  post "reservations/clear_notifications" => "reservations#clear_notifications"

  get "signup" => "users#new", :as => :new_user
  post "signup" => "users#create", :as => :signup_user
  get "login" => "sessions#new", :as => :new_session
  post "login" => "sessions#create", :as => :login_session
  post "logout" => "sessions#destroy", :as => :logout_session
  get "searchresults" => "spots#searchresults"

  root :to => 'spots#index'
end
