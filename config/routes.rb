Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  #get 'clients' => 'static_pages/clients'
  get 'clients' => 'static_pages#clients'
  get 'workers' => 'static_pages#workers'
  get 'ads' => 'static_pages#ads'
  get 'signup' => 'users#new'
end
