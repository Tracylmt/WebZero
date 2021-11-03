Rails.application.routes.draw do
 # devise_scope :user do
 #  get 'sign_in', to: 'devise/sessions#new'
 #  get 'sign_in', to: 'devise/sessions#new'
# end 
  resources :users, only: [:update]
  devise_for :users
  resources :websites
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "home/about"
  get "home/profile"
  root "home#index"
end
