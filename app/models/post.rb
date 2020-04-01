class Post < ApplicationRecord
	validates :user_id, presence: true
	validates :content, presence: true

	belongs_to :user
	has_many   :commentaries, dependent: :destroy
	has_many   :reactions, as: :owner, dependent: :destroy
end
