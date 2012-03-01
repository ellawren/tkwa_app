module ContactsHelper

	def is_employee?
    	true if @contact.employee
  	end

end
