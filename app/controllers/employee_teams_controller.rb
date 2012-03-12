class EmployeeTeamsController < ApplicationController
  

  def edit
    @employee_team = EmployeeTeam.find(params[:id])
    @employee = Contact.find(@employee_team.contact_id)
    @project = Project.find(@employee_team.project_id)
    @phases = @project.available_phases
    render :layout => 'modal' 
  end

  def update
    @employee_team = EmployeeTeam.find(params[:id])
    if @employee_team.update_attributes(params[:employee_team])
      flash[:success] = "Team updated successfully!"
      redirect_to tracking_project_path(Project.find(@employee_team.project_id))
    else
      redirect_to(:back) 
    end
  end

  
end