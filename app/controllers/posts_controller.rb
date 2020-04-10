class PostsController < ApplicationController

	def givePostsParamsPermission (params)
		params.permit(:user_id, :content, :image)
	end

	def create
		Post.create(givePostsParamsPermission(params))
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end

	def destroy
		Post.destroy(params[:id])
		hidePostId = 'post' + params[:id]
		respond_to do |format|
			format.js { render :js =>  "hidePost('#{hidePostId}')" }
		end

	end
end
