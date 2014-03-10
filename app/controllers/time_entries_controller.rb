class TimeEntriesController < ApplicationController
	
	def edit
    	@time_entry = TimeEntry.find(params[:id])
    end

    def update_phases
		project = Project.find(params[:project_id])
		@phases = project.available_phases.map{|a| [a.number, a.number]}.insert(0, "")
		@phase_id = params[:phase_id]
	end

	def update_task_field
		@project = Project.find(params[:project_id])
		@phase_number = params[:phase_number]
		@task_id = params[:task_id]
		@tasks = @project.available_tasks.map{|a| [a.name, a.id]}.insert(0, "")
		@key = params[:key]
	end

end