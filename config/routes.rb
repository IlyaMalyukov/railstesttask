Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'clients' => 'static_pages#clients'
  get 'workers' => 'static_pages#workers'
  get 'ads' => 'static_pages#ads'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
end
