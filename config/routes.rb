Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  put "users/update/:id" => "users#update"
  delete "users/:id" => "users#destroy"
  resources :users, only: [:index, :show] do   
    resources :posts, only: [:index, :new, :create, :show, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      post 'users/login' => 'users#login'
      post 'users/signup' => 'users#signup'
      post 'users/posts/commentonpost' => 'posts#add_comment'
      get  'users/:user_id/posts/:post_id/comments' => 'posts#list_comments'
      get  'users/:user_id/posts' => 'posts#users_posts'
      resources :users, only: [:index, :show]
    end
  end
end
