class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	before_action :configure_permitted_parameters, if:  :devise_controller?


	protected

	  def configure_permitted_parameters

	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

	  end


  # protected

  # def after_sign_in_path_for(resource)
  #   "# return the path based on resource"
  # end

  # def after_sign_out_path_for(resource)
  #   # return the path based on resource
  # end

end
