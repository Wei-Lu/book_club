class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_is_current_user_admin

  protected
	def set_is_current_user_admin
	  @is_current_user_admin = (current_user && current_user.is_admin?)
	end

	def noadmin_redirect
	  @is_current_user_admin = (current_user && current_user.is_admin?)
	  if !@is_current_user_admin
	    redirect_to books_url, notice: "You must be an admin to to access the function"      
	  end
	end

end
