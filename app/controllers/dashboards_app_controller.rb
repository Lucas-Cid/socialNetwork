class DashboardsAppController < ApplicationController
	skip_before_action :verify_authenticity_token

	def showPosts
		@postsType = Post.all.order(:id).last(20).reverse
		@reactionsTimeline = Reaction.where(owner_id:@postsType, user_id:params.require(:user)[:id], owner_type:"Post")

		posts = []
		postHash = {}
		@postsType.each do |post|

			userPost = User.where(id:post.user_id).first

			if (@reactionsTimeline.where(owner_id:post.id).present?)
				user_reaction = @reactionsTimeline.where(owner_id:post.id).first.reactionType
			else
				user_reaction = "none"
			end

			postHash = {
							:user_name     => userPost.name,
							:user_id       => userPost.id,
							:user_reaction => user_reaction,
							:content       => post.content,
							:reactionType1 => post.reactionType1,
							:reactionType2 => post.reactionType2,
							:reactionType3 => post.reactionType3,
							:reactionType4 => post.reactionType4,
							:dislikes      => post.dislikes
					   }
			posts.push(postHash)
		end

		postsReturn = {
						:posts => posts
					  }

		respond_to do |format|
			format.json  { render :json => postsReturn }
		end

	end

end
