Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new' 
  post '/signin', to: 'users#create'
  # Defines the root path route ("/")
  # root "articles#index"
end
