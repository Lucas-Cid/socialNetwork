class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }

  validates :profilePicture, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 15 }, format: { with: /\A@(([a-zA-Z0-9])*(\-)*(\_)*(\.)*)*\z/,
                                       message: "only allows leters, numbers, '-', '_', '.' and spaces"}

  has_many :posts, dependent: :destroy
  has_many :commentaries, dependent: :destroy
  has_many :reactions, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships, dependent: :destroy

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user, dependent: :destroy

  has_one_attached :profilePicture, dependent: :destroy

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

  def areWeFriends(user)
    friendships.where(friend_id:user.id, acceptedRequest:true).present? || inverse_friendships.where(user_id:user.id, acceptedRequest:true).present?
  end

  def userRequestedFriendship(user)
    inverse_friendships.where(user_id:user.id, acceptedRequest:false).present?
  end

  def alreadySentRequest(user)
    friendships.where(friend_id:user.id, acceptedRequest:false).present?
  end

  def deleteFriendship(friend)
    if friendships.where(friend_id:friend.id).first.present?
      Friendship.delete(friendships.where(friend_id:friend.id).first.id)
    else 
      Friendship.delete(inverse_friendships.where(user_id:friend.id).first.id)
    end
  end

  def acceptFriendship(friend)
    @friendship = inverse_friendships.where(user_id:friend.id).first
    @friendship.update(acceptedRequest:true)
  end

  def userIsPostOwner(postInformations)
    if postInformations.require(:owner_type) == "Post"
      type = Post
    else
      type = Commentary
    end

    @subject = type.find(postInformations.require(:owner_id))  
    if self.id == @subject.user_id
      return true
    else
      return false
    end
  end
end
