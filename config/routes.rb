Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  resources :cars do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :show, :update, :destroy]
end
