class DashboardsController < ApplicationController

	before_action :authenticate_user!

	def homepage
		@postsType = Post.all.order(:id).last(5).reverse
		@lastPost_id = @postsType.last.id
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		@pageType = "homepage"
		@optionalId = 0

	end

	def myProfile
		@user = current_user
		@postsType = current_user.posts.order(:id).last(5).reverse
		@lastPost_id = @postsType.last.id
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		@pageType = "myProfile"
		@optionalId = current_user.id
		render :profile
	end

	def userProfile
		@user = User.find(params.require(:id))
		@postsType = @user.posts.order(:id).last(5).reverse
		@lastPost_id = @postsType.last.id
		@reactionsTimeline  = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		@pageType = "userProfile"
		@optionalId = @user.id
		render :profile
	end

	def userReactions
		@user = User.find(params.require(:id))
		@reactions = @user.reactions.where(owner_type:"Post").order(:id).last(5).reverse
		@postsType = []
		@reactions.each do |reaction|
			@postsType << Post.find(reaction.owner_id)
		end
		@lastPost_id = 0;
		if @reactions.present?
			@lastPost_id = @reactions.last.id
		end
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		@pageType = "userReactions"
		@optionalId = @user.id
		render partial: "postsRender"
	end

	def userPosts 
		@user = User.find(params.require(:id))
		@postsType = @user.posts.order(:id).last(5).reverse
		@lastPost_id = @postsType.last.id
		@reactionsTimeline  = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
		@pageType = "userProfile"
		@optionalId = @user.id
		render partial: "postsRender"
	end

	def userFriends
		@user = User.find(params.require(:id))
		@friends = @user.confirmated_friends
		render partial: "friends"
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

	def renderMore 
		if params[:pageType] == "homepage"

			@postsType = Post.where('id < ?', params[:lastPost_id]).order(:id).last(5).reverse
			@lastPost_id = @postsType.last.id
			@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
			@pageType = "homepage"
			@optionalId = 0

		elsif params[:pageType] == "myProfile"
			@user = current_user
			@postsType = current_user.posts.where('id < ?', params[:lastPost_id]).order(:id).last(5).reverse
			@lastPost_id = @postsType.last.id
			@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
			@pageType = "myProfile"
			@optionalId = current_user.id

		elsif params[:pageType] == "userProfile"

			@user = User.find(params[:optionalId])
			@postsType = @user.posts.where('id < ?', params[:lastPost_id]).order(:id).last(5).reverse
			@lastPost_id = @postsType.last.id
			@reactionsTimeline  = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
			@pageType = "userProfile"
			@optionalId = @user.id

		else

			@user = User.find(params[:optionalId])
			@reactions = @user.reactions.where(owner_type:"Post").where('id < ?', params[:lastPost_id]).order(:id).last(5).reverse
			@postsType = []
			@reactions.each do |reaction|
				@postsType << Post.find(reaction.owner_id)
			end
			@lastPost_id = @reactions.last.id
			@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:current_user, owner_type:"Post")
			@pageType = "userReactions"
			@optionalId = @user.id

		end

		render partial: "postsRender"
	end

	def messages
	end
end
