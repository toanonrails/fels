Rails.application.routes.draw do

  root 'home#index'

  get    'signup'=> 'users#new'
  post   'signup'=> 'users#create'
  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout'=> 'sessions#destroy'

  post   'create_relationship' => 'relationships#create'
  delete 'destroy_relationship'=> 'relationships#destroy'

  resources :users, except: [:new, :create]
  # resources :relationships, only: [:create, :destroy]
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :categories
    resources :words
  end
end