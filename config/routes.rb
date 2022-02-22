Rails.application.routes.draw do
  resources :websites
  devise_for :users
  root to: 'websites#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
