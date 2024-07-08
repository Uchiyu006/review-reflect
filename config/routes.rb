Rails.application.routes.draw do
  root 'staticpages#top'

  resources :users, only: %i[new create]
end
