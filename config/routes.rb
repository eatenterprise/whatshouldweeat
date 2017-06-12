Rails.application.routes.draw do

  root 'home#index'

  resources :rounds, only: [:create, :show, :destroy] do
    resources :restaurants, only: [:create, :update]
    get 'start' => 'rounds#start'
  end

  get 'find_key' => 'rounds#find_key'
  get 'rounds/:id/results' => 'rounds#results'
  get ':key' => 'rounds#find_key'
  get 'rounds/:id/group_results' => 'rounds#group_results'
end
