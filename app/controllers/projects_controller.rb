class ProjectsController < ApplicationController

    autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]
    autocomplete :contact, :work_company, :full => true, :scopes => [:consultant_list]

    def new
        @project = (flash[:project]) ? flash[:project] : Project.new # this is so that error message shows up if number validation fails
    end

    def info
        @project = Project.find(params[:id])
        if @project.consultant_teams.count == 0 
            1.times { @project.consultant_teams.build }
        end
        if @project.employee_teams.count == 0
            1.times { @project.employee_teams.build }
        end
    end

    def team
        @project = Project.find(params[:id])
        @employee_teams = @project.employee_teams.ordered
    end

    def billing
        @project = Project.find(params[:id])
        if @project.consultant_teams.count == 0 
            1.times { @project.consultant_teams.build }
        end
    end
  
    def scope
        @project = Project.find(params[:id])
    end

    def tracking
        @project = Project.find(params[:id])
        @employee_teams = @project.employee_teams.ordered
    end

    def fee_calc
        @project = Project.find(params[:id])
        @team_members = EmployeeTeam.find_all_by_project_id(@project.id)
        @phases = @project.available_phases
    end

    def forecast
        @project = Project.find(params[:id])
    end

    def edit_forecast
        @project = Project.find(params[:id])
        render :layout => 'modal' 
    end

    def forecast_index
        @projects = Project.current.all
    end

    def drawing_log
        @project = Project.find(params[:id])
    end

    def patterns
        @project = Project.find(params[:id])
    end

    def marketing
        @project = Project.find(params[:id])
    end

    def schedule
        @project = Project.find(params[:id])
        render :layout => 'schedule' 
    end

    def schedule_full
        @project = Project.find(params[:id])
        render :layout => 'schedule_full' 
    end
  
    def index
        @q = Project.all_projects.search(params[:q])
        @projects = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30).order('number ASC')
        @user = current_user
        if params.has_key?(:q) && @projects.count == 1 
            redirect_to info_project_path(@projects.first(params[:id]))
        else
            render 'index' 
        end
    end

    def current
        @projects = Project.where(:status => "current")
    end
  
    def create
        @project = Project.new(params[:project])

        if @project.save
            flash[:success] = "Project created successfully!"
            redirect_to info_project_path(@project)
        else
            flash[:project] = @project # this is so that error message shows up if number validation fails
            redirect_to new_project_path
        end
    end
  
    def update
        @project = Project.find(params[:id])
        if @project.update_attributes(params[:project])
            flash[:success] = "Project updated successfully!"
            redirect_to(:back) 
        else
            flash[:error] = "Project could not be updated."
            redirect_to(:back) 
        end
    end
  
    def destroy
        Project.find(params[:id]).destroy
        flash[:success] = "Project deleted."
        redirect_to projects_path
    end
  
end
