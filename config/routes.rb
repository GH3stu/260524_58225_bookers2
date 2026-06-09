Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: "homes#top"

  devise_scope :user do
    get 'session/new', to: 'users/sessions#new', as: :new_session
    get 'users/new', to: 'users/registrations#new', as: :new_user
  end
  
  get "home/about" => "homes#about", as: "about"
  
  get "search" => "searches#search"
  
  # get "users/index"  get "users/show"  get "users/edit"から書き換え
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
    resources :notifications, only: [:update]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  post "guest_sign_in", to: "guest_sessions#create", as: :guest_sign_in

end
