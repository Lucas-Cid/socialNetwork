class Post < ApplicationRecord
	validates :user_id, presence: true
	validates :content, presence: true
	validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg']

	belongs_to :user
	has_many   :commentaries, dependent: :destroy
	has_many   :reactions, as: :owner, dependent: :destroy
	has_one_attached :image, dependent: :destroy
end
