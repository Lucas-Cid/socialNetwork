class Reaction < ApplicationRecord
	validates :reactionType, presence: true

	enum reactionType: [:type1, :type2, :type3, :type4, :dislike]

	belongs_to :user
	belongs_to :owner, polymorphic: true


	before_save do |s|
		if owner_type == "Post"
			type = Post
		else
			type = Commentary
		end

		alreadyReactedVerification = type.find(owner_id).reactions.where(user_id:user_id)
		if alreadyReactedVerification.present?
			Reaction.destroy(alreadyReactedVerification.first.id)
		end

		toBeReacted = type.where(id:owner_id).first
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

	before_destroy :undoReaction

	def undoReaction
		if owner_type == "Post"
			type = Post
		else
			type = Commentary
		end

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
