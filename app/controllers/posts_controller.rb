class PostsController < ApplicationController

	def givePostsParamsPermission (params)
		params.permit(:user_id, :content, :image, :post_id)
	end

	def create
		Post.create(givePostsParamsPermission(params))
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
