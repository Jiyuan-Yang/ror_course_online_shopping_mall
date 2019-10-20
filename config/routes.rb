Rails.application.routes.draw do
  get 'shops/new'
  get 'shops/show'
  get 'sessions/new'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/create_shop', to: 'shops#new'
  post '/create_shop', to: 'shops#create'

  resources :users
  resources :shops
end
