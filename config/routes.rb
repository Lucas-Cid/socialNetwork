Rails.application.routes.draw do
  root "dashboards#homepage"
  get "users/addFriend", to: "users#addFriend"
  devise_for :users
  resources :posts, :reactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
