class ReactionsController < ApplicationController

	def giveReactionsParamsPermission (params)
		params.permit(:user_id, :owner_id, :owner_type, :reactionType)
	end

	def create
		permitedParams = giveReactionsParamsPermission(params)
		@user = User.find(params.require(:user_id))
		if @user.userIsPostOwner(permitedParams)
		
		else
			verification = Reaction.alreadyReacted(permitedParams)
			if !verification
				Reaction.create(permitedParams)
			end
		end
		redirect_back(fallback_location: root_path)
	end

end
