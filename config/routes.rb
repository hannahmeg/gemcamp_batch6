Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'students/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
  get 'contact', to: 'welcome#contact'
  get 'about', to: 'welcome#about'

  constraints(ClientDomainConstraint.new) do
    resources :orders, only: [:index]
    resources :posts do
      resources :comments, except: :show
      get :api_news, on: :collection
      member do
        get :unpublish
      end
    end
  end

  # get 'archives', to

  resources :students do
    resources :phone_numbers
  end

  resources :categories, except: :show

  resources :comments, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end

  # resources :orders, only: [:index]
  constraints(AdminDomainConstraint.new) do
    resources :posts, only: [:index] do
    end
    resources :orders, only: [:index] do
      member do
        post :submit
        post :pay
        post :fail
        post :revoke
      end
    end
  end
end


