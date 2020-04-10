class CommentariesController < ApplicationController

	def giveCommentariesParamsPermission (params)
		params.permit(:user_id, :content, :post_id)
	end

	def create
		@commentary = Commentary.new(giveCommentariesParamsPermission(params))
		if @commentary.save
			render partial: "dashboards/simpleCommentary"
		end
	end

	def destroy
		Commentary.destroy(params[:id])
		hideCommentaryId = 'commentary' + params[:id]
		respond_to do |format|
			format.js { render :js =>  "hidePost('#{hideCommentaryId}')" }
		end
	end

end
