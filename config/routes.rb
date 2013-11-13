BlindLove::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    match "/users/sign_in" => "devise/sessions#new", :as => "login"
    match "/users/sign_out" => "devise/sessions#destroy", :as => "logout"
  end
  
  resources :searches, :only => [:index]
  resources :admin, :only => [:index]
  resources :home_pages, :only => [:index]
  resources :basket_items, :only =>[ :create, :destroy]
  resources :orders ,:only => [ :new, :create]

  resources :baskets, :only => [ :show ] do
    member do
      put "update_basket_item"
    end
  end

  resources :users, :except => [:index] do
    resources :addresses
    resources :payments
    resources :orders, :only => [:index, :show] do
      member do
        put "cancel"
      end
    end
  end

  namespace :admin do
    resources :products
    resources :categories
    resources :orders
  end

  resources :departments, :only => [:show] do
    resources :categories, :only => [:show] do
      resources :products, :only => [:show] do
      end
    end
  end

  match "/departments/:id" => "departments#show", :as => "dep"
  match "/categories/:id" => "categories#show", :as => "cat"

  post "departments/:id/categories/:id/", :to => "categories#show"
  root :to => 'home_pages#index'
end
