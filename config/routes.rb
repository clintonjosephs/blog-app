Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  put "users/update/:id" => "users#update"
  delete "users/destroy/:id" => "users#destroy"
  resources :users, only: [:index, :show] do   
    resources :posts, only: [:index, :new, :create, :show]
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
end
