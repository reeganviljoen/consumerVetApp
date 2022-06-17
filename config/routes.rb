Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new' 
  post '/users', to: 'users#create'

  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#authenticate'

  get '/users/:id/show', to: 'users#show'
  # Defines the root path route ("/")
  # root "articles#index"
end
