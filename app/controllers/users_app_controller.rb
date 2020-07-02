class UsersAppController < ApplicationController
	 skip_before_action :verify_authenticity_token
	
	def giveUsersAppParamsPermission (params)
		params.require(:user).permit!
	end

	def create
		
		permiterParams = giveUsersAppParamsPermission(params)
		user = User.new(permiterParams)
		if user.save
			user =    {
					    :user => {:id => user.id}
					  }
		else
			user =    {
					  :user => "false"
					  }
		end

		respond_to do |format|
			format.json  { render :json => user }
		end

	end

	def login
		user = User.find_by_email(params[:user][:email])

		userReturn = {
					:user => { :logged_in => false }
			   }
		# Linha mágica
		if user && user.valid_password?(params[:user][:password])
			userReturn = {
						:user => { 
									:logged_in => true,
									:id        => user.id
								 }
				   }
		end
		respond_to do |format|
			format.json  { render :json => userReturn }
		end
	end
end
