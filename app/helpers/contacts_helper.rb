module ContactsHelper

	def is_employee?
    	true if @contact.employee
  	end

  	#def is_consultant?
  	#	true if @contact.categories.any?{|c| c.name == 'Consultant' }
	#end 

end
