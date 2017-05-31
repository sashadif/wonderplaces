Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admins', as: 'rails_admin'
  
  devise_for :users
  
  root 'home#index'
  
  resources :users do
    resources :places, :only => [:destroy]
  end
  
  resources :places
  resources :categories
  
  match 'places/:id/add_to' => "places#add_to", :via => :post 
  
end