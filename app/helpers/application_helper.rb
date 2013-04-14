module ApplicationHelper
	def formatted_date(date)
		date.strftime("%d %b %Y")
	end

	def get_is_user_admin(user)
  	  if user.is_admin?
        'true'
      else 
        'false'
      end 	
  end

end
