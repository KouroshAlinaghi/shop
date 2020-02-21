Rails.application.routes.draw do
  root 'products#index'

  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"

  resources :orders
  resources :users
  resources :pages
  resources :products do 
    resources :comments
  end
  resources :categories
  resources :carts
  get 'edit', to: 'users#edit'
  post 'users/update'
  get 'carts/show'
  get 'carts', to: 'carts#index'
  get 'categories', to: "categories#index"
  post 'user/user_create_by_admin', to: "users#create_by_admins"
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/products/:id/comments/:id', to: 'comments#show', as: 'comment'
  get '/products/:id/comments/new', to: 'comments#new', as: 'comment_new'
  get '/products/:id/comments/', to: 'comments#index', as: 'comment_index'
  get 'toggle/:id', to: 'products#toggle', as: 'toggle'
  get 'clear', to: 'carts#clear'
  get 'close/:id', to: 'orders#close', as: 'close'
  get 'cancel/:id', to: 'orders#cancel', as: 'cancel'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
