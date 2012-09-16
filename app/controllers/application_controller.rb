class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_admin
		unless current_user.is_admin?
			flash[:error] = "You're not allowed to do/see this :("
			redirect_to root_path
		end
	end
end
