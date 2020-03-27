Rails.application.routes.draw do
  root "dashboards#homepage"
  get "users/addFriend", to: "users#addFriend"
  get "dashboards/myProfile", to: "dashboards#myProfile"
  get "dashboards/userProfile", to: "dashboards#userProfile"
  get "dashboards/messages", to: "dashboards#messages"
  get "dashboards/userReactions", to: "dashboards#userReactions"
  devise_for :users
  resources :posts, :reactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
