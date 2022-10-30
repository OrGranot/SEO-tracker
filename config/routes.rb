Rails.application.routes.draw do
  resources :shared_websites, only: [:create, :udpate, :destroy, :show]
  resources :websites do
    get 'search/add'
    resources :keywords
  end
  devise_for :users
  root to: 'websites#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
