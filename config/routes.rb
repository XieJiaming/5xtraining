Rails.application.routes.draw do
  root 'products#index'
  resources :products, shallow: true
  # resources :user, shallow: true
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
end
