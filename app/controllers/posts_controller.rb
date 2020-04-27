class PostsController < ApplicationController

	def givePostsParamsPermission (params)
		params.permit(:user_id, :content, :image)
	end

	def create
		Post.create(givePostsParamsPermission(params))
		redirect_to :controller => 'dashboards', :action => 'homepage'
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
