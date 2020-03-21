class ReactionsController < ApplicationController

	def giveReactionsParamsPermission (params)
		params.permit(:user_id, :owner_id, :owner_type, :reactionType)
	end

	def create
		permitedParams = giveReactionsParamsPermission(params)
		verification = Reaction.alreadyReacted(permitedParams)
		if !verification
			Reaction.create(permitedParams)
		end
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end
end
