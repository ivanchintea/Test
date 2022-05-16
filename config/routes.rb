Rails.application.routes.draw do
  resources :profiles, only: [ :new, :create, :edit, :update ]
  get 'profiles/:id', to: 'profiles#edit'
  post 'scrape/', to: 'profiles#scrape'

end
