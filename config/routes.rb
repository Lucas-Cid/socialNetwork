Rails.application.routes.draw do
  root "dashboards#homepage"
  get "users/addFriend", to: "users#addFriend"
  get "users/changeProfilePictureModal", to: "users#changeProfilePictureModal"
  post "users/changeProfilePicture", to: "users#changeProfilePicture"
  get "users/removeProfilePicture", to: "users#removeProfilePicture"
  get "dashboards/myProfile", to: "dashboards#myProfile"
  get "dashboards/userProfile", to: "dashboards#userProfile"
  get "dashboards/messages", to: "dashboards#messages"
  get "dashboards/userReactions", to: "dashboards#userReactions"
  get "dashboards/userPosts", to: "dashboards#userPosts"
  get "dashboards/userImages", to: "dashboards#userImages"
  get "dashboards/userFriends", to: "dashboards#userFriends"
  get "dashboards/showPost", to: "dashboards#showPost"
  get "dashboards/sharePost", to: "dashboards#sharePost"
  get "dashboards/renderMore", to: "dashboards#renderMore"
  get "commentaries/makeCommentary", to: "commentaries#makeCommentary"
  post "app/showPosts", to: "dashboards_app#showPosts"
  post "app/friendList", to: "dashboards_app#friendList"
  post "users_app/login", to: "users_app#login"


  get 'api.all_users', to: 'api#index'
  get 'api.profile/:id', to: 'api#profile'
  post 'api.register', to: 'api_user#register'
  post 'api.login', to: 'api_user#login'
  get 'api.showposts', to: 'api_dashboard#show_posts'
  get 'api.react_to_post', to: 'api_dashboard#react_to_post'

  devise_for :users
  resources :posts, :reactions, :commentaries, :users_app
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
