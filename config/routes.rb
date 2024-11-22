Rails.application.routes.draw do
  root to: 'lists#index'

  resources :lists, only: %i[index show new create destroy] do
    resources :bookmarks, only: %i[new create destroy]
    resources :reviews, only: %i[create]
  end
  resources :reviews, only: %i[destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
