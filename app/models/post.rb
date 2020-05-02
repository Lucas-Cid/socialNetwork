class Post < ApplicationRecord
	validates :user_id, presence: true
	validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg']
	validates :content, presence: true, if: :contentPresent?

	belongs_to :user
	has_many   :commentaries, dependent: :destroy
	has_many   :reactions, as: :owner, dependent: :destroy
	belongs_to :post, optional: true
	has_many :posts
	has_one_attached :image, dependent: :destroy

	def contentPresent?
		image.attached? || post_id.present? ? false : true
	end

	def self.getTime(time)
		if Time.now - time < 86400

			secondsDiference = Time.now - time
			if secondsDiference < 3540

				if secondsDiference < 60
					return secondsDiference.to_i.to_s + "s"
				else
					return (secondsDiference / 60).to_i.to_s + "min"
				end

			else
				return (secondsDiference / 3600).to_i.to_s + "h"
			end

		else
			return time.strftime("%d-%m-%Y")
		end
	end

end
