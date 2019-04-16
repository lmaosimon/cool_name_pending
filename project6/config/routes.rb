Rails.application.routes.draw do
  get 'recommendations/new'
  root 'static_pages#home'
  get 'sessions/new'
  get '/signup', to: 'users#new'
  get  '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/newcourse', to: 'courses#new'
  get '/courses', to: 'courses#index'
  get '/allcourses', to: 'courses#admin_index'
  get '/newrecommendation', to: 'recommendations#new'
  get '/recommendations', to: 'recommendations#index'
  get '/allrecommendations', to: 'recommendations#admin_index'
  resources :users
  resources :courses
  resources :recommendations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
