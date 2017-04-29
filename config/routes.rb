Rails.application.routes.draw do
  get '/@:screen_name' => 'profiles#show', as: :profile
  get '/profiles/:id' => 'profiles#archived', as: :archived_profil
  resource :profile, only: [ :edit, :update ]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :bots
  post '/rooms/join/:screen_name' => 'rooms#join', as: :join_room
  post '/rooms/leave/:screen_name' => 'rooms#leave', as: :leave_room
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
