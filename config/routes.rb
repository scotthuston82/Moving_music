Rails.application.routes.draw do
root 'users#home'

  resources :musicians  , only: [:index]
  resources :users do
    resources :bookings, only: [:new, :create, :update]
    resources :reviews, only:[:new, :create, :index]
  end

  get '/bookings/new' => 'bookings#new_no_musician'

  get '/bookings/new/find_musician' => 'bookings#find_musician'

  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
end
