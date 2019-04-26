Rails.application.routes.draw do 
  resources :emargement, :only => [:show]

  resources :syntheses, :only => [:index, :show]

  resources :reunions do
    resources :presences, :only => [:create, :index]
    resources :roles, :only => [:index, :update]
    resources :documents, :only => [:index, :create, :destroy]

    member do
      get :diffuser
    end
  end

  resources :dmsessions do
    resources :documents, :only => [:index, :create, :destroy]
  end

  resources :programmes do
    resources :documents, :only => [:index, :create, :destroy]
  end

  resources :societes
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  get 'storage/add' # page pour uploader les documents
  resources :storage do # cf https://guides.rubyonrails.org/routing.html
    collection do
      delete 'destroy_multiple'
    end
  end 

  match '/mesreunions', to: 'reunions#index', via: [:get]
  match '/signup', to: 'users#new', via: [:get]
  match '/signin',  to: 'sessions#new', via: [:get]
  match '/signout', to: 'sessions#destroy', via: [:get, :delete]
  match '/contact', to: 'pages#contact', via: [:get]
  match '/about', to: 'pages#about', via: [:get]
  match '/help', to: 'pages#help', via: [:get]
  root :to => 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
