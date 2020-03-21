class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }

  has_many :posts
  has_many :commentaries
  has_many :reactions
end
