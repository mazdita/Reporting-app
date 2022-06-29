Rails.application.routes.draw do
  resources :reports
  get 'comments/create'
  get 'comments/update'
  get 'comments/destroy'
  get 'dashboard', to: "home#index", as: "dashboard"
  get 'home/delete_search' , to: 'home#delete_search', as: 'home_delete_search_path'
  get "download", to: "home#download"
  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }

  resources :admins 
  # do
    # get "profile", to: "admins#profile"
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "reports#index"
  #get 'static_pages/home'
  get 'pages/index'

  resources :comments
  
end
