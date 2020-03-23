class UsersController < ApplicationController

	def giveUsersParamsPermission (params)
		params.permit(:user1_id, :user2_id)
	end

	def addFriend
		@user = User.find(params.require(:user1_id))
		@friend = User.find(params.require(:user2_id))
		if @user.areWeFriends(@friend)
			@user.deleteFriendship(@friend)
		elsif @user.userRequestedFriendship(@friend)
			@user.acceptFriendship(@friend)
		else
			@user.friends << @friend
		end
	end
end
