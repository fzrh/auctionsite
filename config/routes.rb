Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users

  resources :items, only: [:show] do
    resources :bids
  end
end
