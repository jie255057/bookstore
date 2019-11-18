Rails.application.routes.draw do
  resources :books
  root 'books#index'
end






# resources :books , only: [:index , :show]
# rails routes