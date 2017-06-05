Rails.application.routes.draw do
    resources :mesreunions

    resources :reunions do
        resources :presences, :only => [:create, :index]
        resources :roles, :only => [:index, :update]
        resources :documents, :only => [:create, :destroy]
    end

    resources :dmsessions do
        resources :documents, :only => [:create, :destroy]
    end

    resources :programmes do
        resources :documents, :only => [:create, :destroy]
    end

    resources :societes
    resources :users
    resources :sessions, :only => [:new, :create, :destroy]

    match '/signup', to: 'users#new', via: [:get]
    match '/signin',  to: 'sessions#new', via: [:get]
    match '/signout', to: 'sessions#destroy', via: [:get, :delete]
    match '/contact', to: 'pages#contact', via: [:get]
    match '/about', to: 'pages#about', via: [:get]
    match '/help', to: 'pages#help', via: [:get]
    root :to => 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
