class PostCommentary < ApplicationRecord
	belongs_to :mainPost, class_name: 'Post'
	belongs_to :commentary, class_name: 'Post'
end
