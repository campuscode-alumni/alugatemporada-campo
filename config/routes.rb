Rails.application.routes.draw do
  devise_for :users
  devise_for :property_owners

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: [:show] do
    get 'search', on: :collection
    resources :price_ranges, only: [:create, :new, :show]
    resources :proposals, only: [:new, :create, :index] do
      post 'accepted', to: 'proposals#accepted'
      post 'reject', to: 'proposals#reject'
    end
  end

  scope :property_owners do
    resources :properties, only: [:index, :show, :new, :create]
  end

  resources :users, only: [:show, :edit, :update] do
    resources :proposals, only: [:index]
  end
end
