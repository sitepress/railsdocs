Rails.application.routes.draw do
  resource :email_authentication
  sitepress_pages
  sitepress_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
