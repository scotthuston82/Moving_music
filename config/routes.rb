Rails.application.routes.draw do
root "users#home"


  resources :musicians
  resources :users
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
end
