class CommentariesController < ApplicationController

	def giveCommentariesParamsPermission (params)
		params.permit(:user_id, :content, :post_id)
	end

	def create
		Commentary.create(giveCommentariesParamsPermission(params))
		respond_to do |format|
		  format.js { render :js => "resetCommentaryInput();" }
		end
	end

	def makeCommentary
		@content = params[:content]
		render partial: "dashboards/simpleCommentary"
	end

end
