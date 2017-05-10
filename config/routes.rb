Rails.application.routes.draw do
  get '/@:screen_name' => 'profiles#show_friendly', as: :profile_friendly
  resources :profiles, only: [ :show ]
  resource :profile, only: [ :edit, :update ]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :bots
  post '/rooms/join/:id' => 'rooms#join', as: :join_room
  post '/rooms/leave/:id' => 'rooms#leave', as: :leave_room
  get '/r/@:screen_name' => 'rooms#show_friendly', as: :room_friendly
  resources :rooms
  resources :access_tokens, except: [ :show ]

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
