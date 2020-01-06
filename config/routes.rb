Rails.application.routes.draw do
  root to: 'pages#welcome'
  resources :users
  resources :pages
  resources :products do 
    resources :comments
  end
  resources :categories
#  resources :carts
  get 'user', to: 'users#show'
  get 'edit', to: 'users#edit'
  post 'users/update'
  get 'carts/show'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
