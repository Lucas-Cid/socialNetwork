class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }

  has_many :posts
  has_many :commentaries
  has_many :reactions

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def all_friends
  	self.friends + self.inverse_friends
  end

  def confirmated_friends
  	friends_array = friendships.map{|friendship| friendship.friend if friendship.acceptedRequest}
    friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.acceptedRequest}
  end

  def confirm_friend(user)
    Friendship.where(user_id:user.id, friend_id:self.id).update(acceptedRequest:true)
  end

  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.acceptedRequest}
  end

  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.acceptedRequest}
  end

end
