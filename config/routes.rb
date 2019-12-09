Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }

  resources :books, only: [:index, :show] do
    member do
      post :comment  #POST books/:id/comment, to: 'books#index'
    end  
  end
  
  resources :publishers, only: [:show]

  root 'books#index'

  namespace :admin do
    resources :books
    resources :publishers
    root 'books#index'
  end
end






# resources :books , only: [:index , :show]
# rails routes