Rails.application.routes.draw do
  devise_for :a_users
  devise_for :users
  resources :bots
  post '/rooms/join/:screen_name' => 'rooms#join', as: :join_room
  post '/rooms/leave/:screen_name' => 'rooms#leave', as: :leave_room
  resources :rooms
  resources :access_tokens, except: [ :show ]
  resources :users, except: [ :index ]

  root to: 'pages#index'

  # Auth
  get '/auth/:privider/callback' => 'sessions#create'
  post '/auth/:privider/callback' => 'sessions#create'
  get '/sign_out' => 'sessions#destroy', as: :signout

  # API
  mount API::Root => '/api/'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  # ActionCable
  mount ActionCable.server => '/cable'
end
