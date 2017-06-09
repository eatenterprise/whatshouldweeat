Rails.application.routes.draw do

  root 'home#index'

  resources :rounds, only: [:create, :show, :destroy]
  get 'find_key' => 'rounds#find_key'

end
