Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:index, :show]
  root 'books#index'


  namespace :admin do
    resources :books
    resources :publishers
    root 'books#index'
  end
end






# resources :books , only: [:index , :show]
# rails routes