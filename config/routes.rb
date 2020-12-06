Rails.application.routes.draw do
  resources :tasks do
    resources :comments
    member do
      put "reply", to: "tasks#reply"
    end
  end
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  root 'tasks#index'
  get 'help' => 'static_pages#help'
  get 'ads' => 'static_pages#ads'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :tasks, only: [:create, :destroy]
end
