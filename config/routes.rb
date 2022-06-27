Rails.application.routes.draw do

  get '/signup', to: 'users#new' 
  post '/users', to: 'users#create'

  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#authenticate'

  resources :users, only: [:show] do
    resources :registrations, only: [:index, :update]
    resources :pets, only: [:index, :new, :create] do
      resources :registrations, only: [:new, :create] do
        resources :appointments , only: [:new, :create]
      end
    end
  end
  get '/users/:id/pets', to: 'pets#index'

  root "users#signin"
end
