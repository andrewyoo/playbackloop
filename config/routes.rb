Rails.application.routes.draw do
  root to: 'pages#index'
  resources :playlists, only: [:show, :update, :destroy] do
    member do
      get :items
    end
  end
  resource :search, only: [:create]
  resources :channels, only: [:show]
  resource :account, only: [:show]
  
  get 'blog' => 'blogs#index', as: :blogs
  get 'blog/:slug' => 'blogs#show', as: :blog
  get 'joke' => 'pages#joke', as: :joke
  get 'about' => 'pages#about', as: :about
  get 'terms' => 'pages#terms', as: :terms
  get 'privacy' => 'pages#privacy', as: :privacy
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
end
