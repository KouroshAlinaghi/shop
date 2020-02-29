Rails.application.routes.draw do
  resources :orders, :pages, :categories, :products
  resources :products do
    resources :comments, except: [:show]
  end
  root 'products#index'
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  get 'edit', to: 'users#edit'
  post 'users/update'
  get 'dashboard', to: 'users#show', as: 'user'
  post 'dashboard/user_create_by_admin', to: "users#create_by_admins", as: 'craete_by_admins'
  delete 'dashboard/:id', to: 'users#destroy', as: 'destroy_user'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
