Rails.application.routes.draw do
  
  root 'staticpages#top'
  resources :users, only: %i[new create]
  resources :reviews
  resources :conversations
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
