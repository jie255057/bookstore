Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }


  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path: ':id/add'
      get :checkout
    end
  end

  resources :orders, only: [:index, :show, :create] do
    member do
      put :cancel
      get :pay
      post :paid
    end
  end

  resources :books, only: [:index, :show] do
    member do
      post :comment  #POST books/:id/comment, to: 'books#index'
    end  
  end
  
  resources :publishers, only: [:show]
  resources :categories, only: [:show]

  namespace :api do
    resources :books, only: [] do
      member do
        post :favorite
      end
    end
  end

  root 'books#index'

  namespace :admin do
    resources :books
    resources :publishers
    resources :categories
    root 'books#index'
  end
end






# resources :books , only: [:index , :show]
# rails routes