require 'sidekiq/web'

Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |user_id, password|
    [user_id, password] == [ENV['SIDEKIQ_BASIC_ID'], ENV['SIDEKIQ_BASIC_PASSWORD']]
  end
  mount Sidekiq::Web => '/sidekiq'
  
  root 'staticpages#top'
  resources :users, only: %i[new create]
  resources :reviews
  resources :conversations do
    collection do
      post 'query'
    end
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
