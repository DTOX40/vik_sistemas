Rails.application.routes.draw do
  root "home#index"

  resources :administradors, except: [:show]
  resources :empresas, except: [:show]
  resources :convites, except: [:show]
end
