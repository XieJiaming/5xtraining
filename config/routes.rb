Rails.application.routes.draw do
  root 'products#index'
  resources :products, shallow: true

  # namespace :admin, path: 'blabla666' do
  #   resources :products, shallow:true
  # end

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'log_out', to: 'sessions#destroy'
  get 'user_show', to: 'sessions#show'
  put 'session_update', to: 'sessions#update'
  get 'delet_confirm', to: 'sessions#delete_confirm'
  delete 'delete', to: 'sessions#delete_account'
end
