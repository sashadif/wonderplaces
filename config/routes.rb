Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admins', as: 'rails_admin'
  
  devise_for :users
  root 'home#index'

end
