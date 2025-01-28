Rails.application.routes.draw do
  root "home#index"

  resources :administradors, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :empresas, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :convites, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
