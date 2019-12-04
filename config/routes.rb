Rails.application.routes.draw do
  root 'static_pages#home'
  get 'shopping_carts/show'
  get 'products/new'
  get 'products/show'
  get 'shops/new'
  get 'shops/show'
  get 'sessions/new'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'

  get '/all_users', to: 'static_pages#all_users'
  get '/all_shops', to: 'static_pages#all_shops'
  get '/all_orders', to: 'static_pages#all_orders'

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/users/:id/user_shop', to: 'users#show_shops', as: 'user_shop'
  # this is used for sellers to see there shops, for buyer, just use shop id to get shop_path(id)

  get '/users/:id/user_shop/:shop_id', to: 'shops#show', as: 'show_shop_get'
  delete '/users/:id/user_shop/:shop_id', to: 'shops#destroy'
  get '/users/:id/create_shop', to: 'shops#new', as: 'create_shop_get'
  post '/users/:id/create_shop', to: 'shops#create', as: 'create_shop_post'

  get '/users/:id/user_shop/:shop_id/create_product', to: 'products#new', as: 'create_product_get'
  post '/users/:id/user_shop/:shop_id/create_product', to: 'products#create', as: 'create_product_post'

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

  get '/users/:id/shopping_cart/cart_item_amount_add/:cart_item_id',
      to: 'shopping_cart_items#item_amount_add', as: 'cart_item_amount_add'
  get '/users/:id/shopping_cart/cart_item_amount_subtract/:cart_item_id',
      to: 'shopping_cart_items#item_amount_subtract', as: 'cart_item_amount_subtract'
  delete '/users/:id/shopping_cart/cart_item_destroy/:cart_item_id',
         to: 'shopping_cart_items#destroy', as: 'cart_item_destroy'

  delete '/users/:id/favorite/favorite_item_destroy/:favorite_item_id',
         to: 'favorite_items#destroy', as: 'favorite_item_destroy'

  delete '/users/:id/order/order_destroy/:order_id',
         to: 'orders#destroy', as: 'order_destroy'

  get '/category/:category', to: 'products#show_one_category', as: 'show_one_category'

  delete '/orders/:order_id/:order_item_id', to: 'order_items#destroy', as: 'order_item_destroy'

  post '/search', to: 'search_results#search', as: 'search_results_display'

  get '/orders/:order_id/:order_item_id/update_status', to: 'order_items#update_status', as: 'update_order_status'

  get '/orders/users/:user_id/graph', to: 'orders#graph', as: 'order_graph'

  post '/orders/users/:user_id/graph/monthly', to: 'orders#monthly', as: 'monthly_graph'

  post '/orders/users/:user_id/graph/month_average', to: 'orders#month_average', as: 'month_average_graph'

  get '/orders/users/:user_id/graph/category_graph', to: 'orders#category', as: 'category_graph'

  get '/users/:id/user_shop/:shop_id/graph', to: 'shops#graph', as: 'shops_graph'

  post '/users/:id/user_shop/:shop_id/monthly', to: 'shops#monthly', as: 'shops_monthly'

  post '/orders/users/:user_id/graph/month_income', to: 'orders#month_income', as: 'month_income_graph'

  post '/orders/users/:user_id/graph/year_income', to: 'orders#year_income', as: 'year_income_graph'

  post 'products/:product_id/monthly', to:'products#monthly',as:'product_monthly_graph'






  resources :users
  resources :shops
  resources :products
  resources :orders
end
