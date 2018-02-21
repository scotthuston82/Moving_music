Rails.application.routes.draw do

  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
end
