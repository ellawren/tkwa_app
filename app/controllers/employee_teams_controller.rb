class EmployeeTeamsController < ApplicationController
  
    def new
        @employee_team = EmployeeTeam.new
        @user = User.find(params[:user_id])
        @employee_team.user_id = params[:user_id]
        @projects = Project.where(:status => "current").order('number ASC')
        render :layout => 'modal' 
    end
  
    def edit
        @employee_team = EmployeeTeam.find(params[:id])
        @user = User.find(@employee_team.user_id)
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

    def create
        @employee_team = EmployeeTeam.new(params[:employee_team])
        if @employee_team.save
            redirect_to(:back) 
        else
            render 'new'
        end
    end
  
end