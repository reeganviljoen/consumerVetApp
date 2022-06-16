Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new' 
  post '/users', to: 'users#create'

  get '/signin', to: 'users#signin'
  post '/sigin', to: 'users#authenticate'
  # Defines the root path route ("/")
  # root "articles#index"
end
