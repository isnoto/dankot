Rails.application.routes.draw do
  root 'pages#home'

  namespace :admin do
    get '/', to: 'main#index'
    get '/profile', to: 'profile#edit'
    put '/profile', to: 'profile#update'
    resources :main_page_photos
    resources :portfolio_photos
    resources :categories
    resources :services
  end

  resources :sessions
  resources :contacts, only: [:new, :create]
  resources :portfolio, only: [:index] do
    get 'photos', on: :collection
  end

  delete 'logout', to: 'sessions#destroy'
  get 'admin',     to: 'admin#index'
  get 'portfolio', to: 'portfolio#index'
  get 'photos',    to: 'portfolio#photos'
  get 'services',  to: 'pages#services'
  get 'about',     to: 'pages#about'
  get 'contacts',  to: 'contacts#new'
end
