class Commentary < ApplicationRecord
	validates :user_id, presence: true
	validates :content, presence: true

	belongs_to :user
	belongs_to :post
	has_many :reactions, as: :owner, dependent: :destroy
end
