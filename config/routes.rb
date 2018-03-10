Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: [:show, :new, :create] do
    resources :price_ranges, only: [:create, :new, :show]
    get 'search', on: :collection
    resources :proposals, only: [:new, :create]
  end
end
