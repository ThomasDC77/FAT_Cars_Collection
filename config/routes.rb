Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'profile', to: 'users#profile'
  get 'profile/owner', to: 'users#owner'

  # Defines the root path route ("/")
  resources :cars do
    resources :bookings, only: %i[create new update edit]
  end
  resources :bookings, only: %i[destroy]
end
