Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new' 
  post '/users', to: 'users#create'

  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#authenticate'

  # get '/users/:id/show', to: 'users#show'
  resources :users, only: [:show] do
    resources :pets, only: [:index] do
      resources :registrations, only: [:new, :create]
    end
  end
  get '/users/:id/pets', to: 'pets#index'
  # Defines the root path route ("/")
  root "users#signin"
end
