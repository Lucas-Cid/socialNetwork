class Reaction < ApplicationRecord
	validates :post_id, presence: true
	validates :user_id, presence: true
	validates :reactionType, presence: true

	enum reactionType: [:type1, :type2, :type3, :type4, :dislike]

	belongs_to :user
	belongs_to :post

	before_save do |s|
		alreadyReactedVerification = Post.find(self.post_id).reactions.where(user_id:self.user_id)
		if alreadyReactedVerification.present?
			Reaction.destroy(alreadyReactedVerification.first.id)
		end

		post = Post.where(id:self.post_id).first
		case self.reactionType	
			when "type1"
				post.update(reactionType1:post[:reactionType1]+1)
			when "type2"
				post.update(reactionType2:post[:reactionType2]+1)
			when "type3"
				post.update(reactionType3:post[:reactionType3]+1)
			when "type4"
				post.update(reactionType4:post[:reactionType4]+1)
			when "dislike"
				post.update(dislikes:post[:dislikes]+1)

		end
	end

	before_destroy :undoReaction

	def undoReaction
		post = Post.where(id:self.post_id).first
		case self.reactionType	
			when "type1"
				post.update(reactionType1:post[:reactionType1]-1)
			when "type2"
				post.update(reactionType2:post[:reactionType2]-1)
			when "type3"
				post.update(reactionType3:post[:reactionType3]-1)
			when "type4"
				post.update(reactionType4:post[:reactionType4]-1)
			when "dislike"
				post.update(dislikes:post[:dislikes]-1)

		end
	end
end
