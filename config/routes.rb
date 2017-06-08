Rails.application.routes.draw do

  root 'home#index'

  resources :rounds, only: [:create, :show, :destroy]


end
