Rails.application.routes.draw do
  root to: 'sessions#new'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/welcome', to: 'welcome#index'
  resources :administradors, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :empresas, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :convites, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
