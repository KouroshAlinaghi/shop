Rails.application.routes.draw do
  root to: 'pages#welcome'
  resources :pages
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  get 'user', to:  'users#show'
  post 'user/user_create_by_admin', to: "users#create_by_admins"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
