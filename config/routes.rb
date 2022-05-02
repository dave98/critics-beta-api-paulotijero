Rails.application.routes.draw do
  root "games#index"

  resources :critics
  resources :involved_companies

  resources :games do
    resources :critics # games/:game_id/critics/:id

    # /games/:id/add_genre
    post "add_genre", on: :member
    # /games/:id/remove_genre
    delete "remove_genre", on: :member

    # /games/:id/add_platform
    post "add_platform", on: :member
    # /games/:id/remove_platform
    delete "remove_platform", on: :member # games/:id/remove_platform
  end

  resources :platforms
  resources :genres
  resources :companies do
    resources :critics
  end

  resources :users, only: %i[new create]

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create" # POST sessions_path => /sessions
  delete "/sessions", to: "sessions#destroy" # DELETE sessions_path => /sessions
  get "/profile", to: "users#edit"
  patch "/profile", to: "users#update"
  post "/profile", to: "users#create"
end
