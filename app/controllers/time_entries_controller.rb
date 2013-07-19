class TimeEntriesController < ApplicationController
	def edit
    	@time_entry = TimeEntry.find(params[:id])
    end

    def update_phases
		# updates artists and songs based on genre selected
		project = Project.find(params[:project_id])
		# map to name and id for use in our options_for_select
		@phases = project.available_phases.map{|a| [a.number, a.id]}.insert(0, "")
		@phase_id = params[:phase_id]
	end

end