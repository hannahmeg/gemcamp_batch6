Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'students/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  get 'contact', to: 'welcome#contact'
  get 'about', to: 'welcome#about'
  # get 'posts/index', to: 'posts#index'
  # get 'posts/new', to: 'posts#new'
  resources :posts do
    resources :comments, except: :show
    get :api_news, on: :collection
  end

  resources :students do
    resources :phone_numbers
  end

  resources :categories, except: :show

  resources :comments, only: [:index]
end
