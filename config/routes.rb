Rails.application.routes.draw do
  root 'static_pages#home'

  scope :admin, module: "admin" do
    resources :main_page_photos, :portfolio_photos, :categories
  end

  get 'admin',     to: 'admin#index'
  get 'portfolio', to: 'static_pages#portfolio'
  get 'price',     to: 'static_pages#price'
  get 'about',     to: 'static_pages#about'
  get 'contacts',  to: 'static_pages#contacts'
end
