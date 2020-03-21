class PostsController < ApplicationController

	def givePostsParamsPermission (params)
		params.permit(:user_id, :content)
	end

	def create
		Post.create(givePostsParamsPermission(params))
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end
end
