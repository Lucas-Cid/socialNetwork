class PostsController < ApplicationController

	def givePostsParamsPermission (params)
		params.permit(:user_id, :content, :image, :post_id)
	end

	def create
		Post.create(givePostsParamsPermission(params))
		if params[:post_id].present?
			sharedPost = Post.where(id:params[:post_id])
			if sharedPost.present?
				shareCount = sharedPost.first.shareCount
				shareCount += 1
				sharedPost.first.update(shareCount:shareCount)
			end
		end
		if !params[:share]
			redirect_to :controller => 'dashboards', :action => 'homepage'
		end
	end

	def destroy
		if Post.find(params[:id]).image.attached?
			Post.find(params[:id]).image.purge
		end
		Post.destroy(params[:id])
		hidePostId = 'post' + params[:id]
		respond_to do |format|
			format.js { render :js =>  "hidePost('#{hidePostId}')" }
		end

	end
end
