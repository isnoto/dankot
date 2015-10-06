Rails.application.routes.draw do
  root 'static_pages#home'

  get '/portfolio' => 'static_pages#portfolio'
  get '/price'     => 'static_pages#price'
  get '/about'     => 'static_pages#about'
  get '/contacts'  => 'static_pages#contacts'
end
