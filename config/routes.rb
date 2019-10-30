Rails.application.routes.draw do
  get 'shopping_carts/show'
  get 'products/new'
  get 'products/show'
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
  get '/users/:id/user_shop', to: 'users#show_shops', as: 'user_shop'
  # this is used for sellers to see there shops, for buyer, just use shop id to get shop_path(id)

  get '/users/:id/create_shop', to: 'shops#new', as: 'create_shop_get'
  post '/users/:id/create_shop', to: 'shops#create', as: 'create_shop_post'

  get '/shops/:id/create_product', to: 'products#new', as: 'create_product_get'
  post '/shops/:id/create_product', to: 'products#create', as: 'create_product_post'

  get '/users/:id/shopping_cart', to: 'shopping_carts#show', as: 'user_shopping_cart'
  post '/products/:id/add_to_shopping_cart',
       to: 'shopping_carts#add_to_shopping_cart', as: 'add_to_shopping_cart'

  get '/users/:id/favorite', to: 'favorites#show', as: 'user_favorite'
  post '/products/:id/add_to_favorite',
       to: 'favorites#add_to_favorite', as: 'add_to_favorite'

  post '/products/:id/add_one_item_to_order',
       to: 'orders#add_one_item_to_order', as: 'add_one_item_to_order'
  post '/users/:id/add_items_in_shopping_cart_to_order',
       to: 'orders#add_items_in_shopping_cart_to_order', as: 'add_items_in_shopping_cart_to_order'

  get '/users/:id/order', to: 'orders#list_orders', as: 'list_orders' 

  resources :users
  resources :shops
  resources :products
  resources :orders
end
