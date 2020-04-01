Rails.application.routes.draw do
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles #short way

  resources :users, except: [:new]
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]
end
