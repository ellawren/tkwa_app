module ContactsHelper

	def is_employee?
    	true if @contact.employee
  	end

  	def has_current_projects?(employee)
    	true if employee.employee_teams.current.count >= 1
  	end

  	def has_completed_projects?(employee)
    	true if employee.employee_teams.completed.count >= 1
  	end

end
