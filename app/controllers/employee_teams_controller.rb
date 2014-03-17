class EmployeeTeamsController < ApplicationController
  
    def new
        @employee_team = EmployeeTeam.new
        @user = User.find(params[:user_id])
        @employee_team.user_id = params[:user_id]
        @projects = Project.where(:status => "current").order('name ASC')
        render :layout => 'modal' 
    end
  
    def edit
        @employee_team = EmployeeTeam.find(params[:id])
        @project = Project.find(@employee_team.project_id)
        @user = User.find(@employee_team.user_id)
        @data_record = DataRecord.find_or_create_by_year_and_user_id(Date.today.cwyear, @user.id)
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
            flash[:success] = "Employee successfully added to team!"
            redirect_to(:back) 
        else
            flash[:error] = "Employee could not be added to team. Please try again."
            redirect_to(:back)
        end
    end
  
end