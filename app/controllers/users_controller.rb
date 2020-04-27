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

	def changeProfilePictureModal
		respond_to do |format|

		    format.html

		    format.js

		end
	end

	def changeProfilePicture
		if current_user.profilePicture.attached?
			current_user.profilePicture.delete
		end
		current_user.profilePicture.attach(params[:profilePicture])
		redirect_back(fallback_location: root_path)
	end

	def removeProfilePicture
		if current_user.profilePicture.attached?
			current_user.profilePicture.delete
		end
		redirect_back(fallback_location: root_path)
	end
end
