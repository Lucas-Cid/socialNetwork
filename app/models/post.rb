class Post < ApplicationRecord
	validates :user_id, presence: true
	validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg']
	validates :content, presence: true, if: :imageNotPresent?

	belongs_to :user
	has_many   :commentaries, dependent: :destroy
	has_many   :reactions, as: :owner, dependent: :destroy
	belongs_to :post, optional: true
	has_many :posts
	has_one_attached :image, dependent: :destroy

	def imageNotPresent?
		image.attached? ? false : true
	end
end
