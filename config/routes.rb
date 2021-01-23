Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "blogs", to: "blogs#index" 
  # get "blogs/new", to:"blogs#new"
  # post "blogs", to:"blogs#create" 
  # get "blogs/:id", to:"blogs#show"
  resources :blogs
end
