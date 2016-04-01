Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users

  resources :listings, except: [:index, :destroy] do
    resources :bids, only: [:new, :create]
  end
end
