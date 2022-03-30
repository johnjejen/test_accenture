Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 

  resources :book_suggestions, only: %i[create]

  resources :books, only: %i[index show] do
    collection do
      get :book_information
      get :new_book
      post :favorite_books
      get :my_books
     
    end
  end
  
  resources :users, only:[] do
    collection do
      get :search_users
      get :close_account
      get :activate_account
     
    end
   resources :rents, only: %i[index create]
  end

  
  get "index" => 'index#index'
  get '/close_account/:token' => 'users#close_account_do'
  get '/activate_account/:token' => 'users#activate_account_do'
  
  mount_devise_token_auth_for 'User', at: 'auth', :controllers => { :omniauth_callbacks => 'omniauth' }, via: [:get, :post]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
