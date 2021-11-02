Rails.application.routes.draw do
  resources :websites
  get 'home/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
end
