class UsersController < ApplicationController

	def giveUsersParamsPermission (params)
		params.permit(:user1_id, :user2_id)
	end

	def addFriend
		@user = User.find(params.require(:user1_id))
		@friend = User.find(params.require(:user2_id))
		if @user.areWeFriends(@friend)
			if @user.friendships.where(friend_id:params.require(:user2_id)).first.present?
				Friendship.delete(@user.friendships.where(friend_id:params.require(:user2_id)).first.id)
			else 
				Friendship.delete(@user.inverse_friendships.where(user_id:params.require(:user2_id)).first.id)
			end
		elsif @user.userRequestedFriendship(@friend)
			@friendship = @user.inverse_friendships.where(user_id:params.require(:user2_id)).first
			@friendship.update(acceptedRequest:true)
		else
			@user.friends << @friend
		end
		redirect_to :controller => 'dashboards', :action => 'homepage'
	end
end
