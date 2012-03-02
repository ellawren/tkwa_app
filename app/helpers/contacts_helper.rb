module ContactsHelper

	def is_employee?
    	true if @contact.employee
  	end

  	def has_current_projects?
    	true if @contact.employee_teams.current.count >= 1
  	end

  	def has_completed_projects?
    	true if @contact.employee_teams.completed.count >= 1
  	end

end
