class Reaction < ApplicationRecord
	validates :reactionType, presence: true

	enum reactionType: [:type1, :type2, :type3, :type4, :dislike]

	belongs_to :user
	belongs_to :owner, polymorphic: true

	before_destroy :undoReaction

	after_create do |s|
		addReaction
	end

	def postOrComment(owner_type)

		if owner_type == "Post"
			Post
		else
			Commentary
		end
	end

	def addReaction
		type = postOrComment(owner_type)

		toBeReacted = type.find(owner_id)
		case reactionType	
			when "type1"
				toBeReacted.update(reactionType1:toBeReacted[:reactionType1]+1)
			when "type2"
				toBeReacted.update(reactionType2:toBeReacted[:reactionType2]+1)
			when "type3"
				toBeReacted.update(reactionType3:toBeReacted[:reactionType3]+1)
			when "type4"
				toBeReacted.update(reactionType4:toBeReacted[:reactionType4]+1)
			when "dislike"
				toBeReacted.update(dislikes:toBeReacted[:dislikes]+1)
		end
	end

	def self.alreadyReacted(params)
		@user = User.find(params.require(:user_id))
		@userReaction = @user.reactions.where(owner_id:params.require(:owner_id)).first
		if @userReaction.present?
			if @userReaction.reactionType == params.require(:reactionType)
				@userReaction.destroy
			else
				@userReaction.undoReaction
				@userReaction.update(reactionType:params.require(:reactionType))
				@userReaction.addReaction

			end
			return true
		end
		return false
	end

	def undoReaction
		type = postOrComment(owner_type)

		toLostReaction = type.find(owner_id)
		case reactionType	
			when "type1"
				toLostReaction.update(reactionType1:toLostReaction[:reactionType1]-1)
			when "type2"
				toLostReaction.update(reactionType2:toLostReaction[:reactionType2]-1)
			when "type3"
				toLostReaction.update(reactionType3:toLostReaction[:reactionType3]-1)
			when "type4"
				toLostReaction.update(reactionType4:toLostReaction[:reactionType4]-1)
			when "dislike"
				toLostReaction.update(dislikes:toLostReaction[:dislikes]-1)

		end
	end

end
