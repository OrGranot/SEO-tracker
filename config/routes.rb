Rails.application.routes.draw do
  resources :shared_websites
  resources :websites, exept: %i[new edit] do
    get 'search/add_ranks'
    resources :keywords do
      get 'search/create'
    end
  end
  devise_for :users
  root to: 'websites#index'
end
