Rails.application.routes.draw do
  resources :users do
    resources :bookings, only: [:new, :create]
  end
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
end
