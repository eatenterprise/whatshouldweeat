Rails.application.routes.draw do

  root 'home#index'

  resources :rounds, only: [:create, :show, :destroy] do
    resources :restaurants, only: [:create]
    get 'start' => 'rounds#start'
  end
  get 'find_key' => 'rounds#find_key'

  get 'nearby_restaurants' => 'restaurants#find_nearby'
  get 'rounds/:id/results' => 'rounds#results'

end
