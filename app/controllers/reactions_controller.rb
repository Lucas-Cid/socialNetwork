class ReactionsController < ApplicationController

	def giveReactionsParamsPermission (params)
		params.permit(:user_id, :owner_id, :owner_type, :reactionType)
	end

	def create
		Reaction.create(giveReactionsParamsPermission(params))
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end
end
