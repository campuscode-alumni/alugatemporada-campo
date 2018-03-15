Rails.application.routes.draw do
  devise_for :property_owners

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: [:show] do
    get 'search', on: :collection
    resources :price_ranges, only: [:create, :new, :show]
    resources :proposals, only: [:new, :create, :index]
  end

  resources :property_owners, only: [:index] do
    resources :properties, only: [:index, :show, :new, :create]
  end
end
