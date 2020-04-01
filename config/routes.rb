Rails.application.routes.draw do
  root "dashboards#homepage"
  get "users/addFriend", to: "users#addFriend"
  get "dashboards/myProfile", to: "dashboards#myProfile"
  get "dashboards/userProfile", to: "dashboards#userProfile"
  get "dashboards/messages", to: "dashboards#messages"
  get "dashboards/userReactions", to: "dashboards#userReactions"
  get "dashboards/showPost", to: "dashboards#showPost"
  get "dashboards/renderMore", to: "dashboards#renderMore"
  post "app/showPosts", to: "dashboards_app#showPosts"
  post "app/friendList", to: "dashboards_app#friendList"
  post "users_app/login", to: "users_app#login"
  devise_for :users
  resources :posts, :reactions, :commentaries, :users_app
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
