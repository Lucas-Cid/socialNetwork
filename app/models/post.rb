class Post < ApplicationRecord
	validates :user_id, presence: true
	validates :content, presence: true

	belongs_to :user
	has_many :reactions

	has_many :postComments, foreign_key: :commentary_id, class_name: 'PostCommentary'
	has_many :commentaries, through: :postComments

	has_many :posts, foreign_key: :post_id, class_name: 'PostCommentary'
	has_many :mainPosts, through: :post
end
