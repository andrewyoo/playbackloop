Rails.application.routes.draw do
  root to: 'pages#index'
  resources :playlists, only: [:show, :create] do
    member do
      get :items
    end
  end
  resources :channels, only: [:show]
  resource :account, only: [:show]
  
  get 'about' => 'pages#about', as: :about
  get 'terms' => 'pages#terms', as: :terms
  get 'privacy' => 'pages#privacy', as: :privacy
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
end
