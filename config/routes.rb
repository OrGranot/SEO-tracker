Rails.application.routes.draw do
  resources :shared_websites
  resources :websites, exept: %i[new edit] do
    get 'search/add_ranks'
    get 'grouped_searches'
    resources :keywords do
      get 'search/create'
    end
  end
  devise_for :users
  root to: 'websites#index'
end
