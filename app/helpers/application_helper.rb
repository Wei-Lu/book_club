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
  
  def pluralize_second_without_count(count, noun, text = nil)
    if count < -1 or count == 0 or count > 1
      return noun
    end
    return "#{noun.pluralize}#{text}"
  end  

end
