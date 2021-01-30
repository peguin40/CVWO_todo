Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  #resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :tasks, only: [:create, :index]

  # User Creation Routes
  get 'signup', to: 'users#new'
  # Login/Logout routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  # Task Routes
  get 'task', to: 'tasks#index'
  post 'task', to: 'tasks#create'
  post 'task/:id', to: 'tasks#update'
  # By Category
  get ':name', to: 'category#show'
  get '/task/:id/edit', to: 'tasks#edit'
  post '/task/:id/toggle', to: 'tasks#toggle'
  delete '/task/:id', to: 'tasks#destroy'
  # Placeholder route require debug
  get 'task/:name', to: 'category#show'
end
