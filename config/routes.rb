Rails.application.routes.draw do
root 'users#home'

  resources :musicians  , only: [:index]
  get 'users/updatepassword', :to => 'users#updatepassword'
  resources :users do
    resources :equipment, only: [:new, :create, :edit, :update, :destroy]
    resources :bookings, only: [:new, :create, :update, :destroy] do
      resources :reviews, only:[:new, :create, :index]
    end
  end

  get '/bookings/new' => 'bookings#new_no_musician'
  get '/bookings/map' => 'bookings#map'

  # get '/bookings/new/find_musicians' => 'bookings#find_musicians'
  get '/bookings/musicians_in_radius' => 'bookings#musicians_in_radius'

  post '/bookings/search_musicians' => 'bookings#search_musicians'

  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'

#  get 'update' => 'user_controller#update'
# end

end
