Rails.application.routes.draw do
  root to: 'pages#index'
  resources :playlists, only: [:show, :create]
  get '/auth/:provider/callback', to: 'sessions#create'
end
