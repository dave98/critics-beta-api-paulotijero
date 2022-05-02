Rails.application.routes.draw do
  devise_for :users

  root "games#index"

  resources :critics
  resources :involved_companies
  resources :games do
    resources :critics

    # /games/:id/add_genre
    post "add_genre", on: :member
    # /games/:id/remove_genre
    delete "remove_genre", on: :member

    # /games/:id/add_platform
    post "add_platform", on: :member
    # /games/:id/remove_platform
    delete "remove_platform", on: :member
  end
  resources :platforms
  resources :genres
  resources :companies do
    resources :critics
  end

  # get "/profile", to: "users#show", as: "user"
end
