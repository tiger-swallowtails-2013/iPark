IPark::Application.routes.draw do
  resources :users, only: [:new, :create]  path_names: { new: 'signup'}
  resources :spots, only: [:new, :create, :show, :index, :destroy]

  # get sessions/login
  # post sessions/login
  # post sessions/logout
end
