class DashboardsController < ApplicationController

	def homepage
		@postsType = Post.all.order(:id).last(20).reverse
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")

	end

	def myProfile
		@user = current_user
		@postsType = current_user.posts.order(:id).last(20).reverse
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")

		render :profile
	end

	def userProfile
		@user = User.find(params.require(:id))
		@postsType = @user.posts.order(:id).last(20).reverse
		@reactionsTimeline  = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")

		render :profile
	end

	def userReactions
		@user = User.find(params.require(:id))
		@reactions = @user.reactions.order(:id).last(20).reverse
		@postsType = []
		@reactions.each do |reaction|
		@postsType << Post.find(reaction.owner_id)

		end
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		render :profile
	end

	def showPost
		@post = Post.find(params.require(:post_id))
		@commentaries = @post.commentaries.order(:id)
		@postsType = @commentaries
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Commentary")

		  respond_to do |format|

		    format.html

		    format.js

		  end

	end

	def messages
	end
end
