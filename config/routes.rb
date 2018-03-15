Rails.application.routes.draw do
  devise_for :users
  devise_for :property_owners

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :properties, only: [:show] do
    get 'search', on: :collection
    resources :price_ranges, only: [:create, :new, :show]
    resources :proposals, only: [:new, :create, :index]
  end

  scope :property_owners do
    resources :properties, only: [:index, :show, :new, :create]
  end

  scope :users do
    resources :proposals, only: [:index]
  end
end


# TO-DO: Precisamos corrigir o relacionamento das propostas para que as mesmas estejam disponíveis para o property_owner visualizar.
