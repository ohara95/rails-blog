Rails
  .application
  .routes
  .draw do
    resources :comments, only: %i[create destroy]

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # get "blogs", to: "blogs#index"
    # get "blogs/new", to:"blogs#new"
    # post "blogs", to:"blogs#create"
    # get "blogs/:id", to:"blogs#show"
    resources :blogs
    resources :users, only: %i[new create]
    root 'home#index'
    get 'mypage', to: 'users#me'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
