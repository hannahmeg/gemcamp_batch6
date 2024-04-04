Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  get 'contact', to: 'welcome#contact'
  get 'about', to: 'welcome#about'
  get 'posts/index', to: 'posts#index'
  get 'posts/new', to: 'posts#new'
  resources :posts
end
