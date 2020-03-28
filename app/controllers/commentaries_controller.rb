class CommentariesController < ApplicationController

	def giveCommentariesParamsPermission (params)
		params.permit(:user_id, :content, :post_id)
	end

	def create
		Commentary.create(giveCommentariesParamsPermission(params))
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end

end
