Rails.application.routes.draw do
  root 'products#index'
  resources :products, shallow: true

  namespace :admin, path: 'blabla666' do
    resources :products, shallow:true do 

    end

    resources :users, shallow:true do 
      member do 
        get 'user_product', to: 'users#products_show'        
      end
    end

    # resources :admins, shallow:true do 
    #   collection do 
    #     get 'user', to: 'admins#user'
    #     get 'product', to: 'admins#product'  
    #     get 'index', to: 'admins#index'
        
    #     get 'user_new', to: 'admins#user_new'
    #     post 'user_create', to: 'admins#user_create'

    #     get 'product_new', to: 'admins#product_new'
    #     post 'product_create', to: 'admins#product_create'
    #   end

    #   member do 
    #     delete 'user_destroy', to: 'admins#user_destroy'
    #     get 'user_edit', to: 'admins#user_edit'
    #     put 'user_update', to: 'admins#user_update'

    #     get 'user_product', to: 'admins#user_products_show'
        
    #     delete 'product_destroy', to: 'admins#product_destroy'
    #     get 'product_edit', to: 'admins#product_edit'
    #     put 'product_update', to: 'admins#product_update'
    #   end
    # end
  end

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
