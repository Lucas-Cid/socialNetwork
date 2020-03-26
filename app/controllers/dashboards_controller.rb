class DashboardsController < ApplicationController

	def homepage
		@postsType = Post.all
	end

	def myProfile
		@user = current_user
		@postsType = current_user.posts
		render :profile
	end

	def userProfile
		@user = User.find(params.require(:id))
		@postsType = @user.posts
		render :profile
	end

	def messages
	end
end
