class TimeEntriesController < ApplicationController
	
	def edit
    	@time_entry = TimeEntry.find(params[:id])
    end

    def update_phases
		project = Project.find(params[:project_id])
		@phases = project.available_phases.map{|a| [a.number, a.number]}.insert(0, "")
		@phase_id = params[:phase_id]
	end

end