Rails.application.routes.draw do
  root 'products#index'
  resources :products, shallow: true
end
