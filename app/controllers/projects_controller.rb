class ProjectsController < ApplicationController

    autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]
    autocomplete :contact, :work_company, :full => true, :scopes => [:consultant_list]

    def new
        @project = (flash[:project]) ? flash[:project] : Project.new # this is so that error message shows up if number validation fails
    end

    def info
        @project = Project.find(params[:id])
        @employee_teams = @project.employee_teams.ordered
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
        date = Date.today.beginning_of_month
        (1..12).each do
            Actual.where(project_id: @project.id, year: date.cwyear, month: date.month).first_or_create
            date = (date - 1).beginning_of_month
        end
        @actuals = @project.actuals.order("year ASC, month ASC, id ASC")
    end
  
    def scope
        @project = Project.find(params[:id])
    end

    def tracking
        @project = Project.find(params[:id])
        @employee_teams = @project.employee_teams.includes(:user)
        @available_phases = @project.available_phases
        @total_target_fees_all = @project.total_target_fees_all
        @total_actual_fees_all = @project.total_actual_fees_all
    end

    def fee_calc
        @project = Project.find(params[:id])
        @team_members = EmployeeTeam.where(project_id: @project.id)
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

    def billing_worksheet #edit_all
        @projects = Project.current.order("name ASC").paginate(:page => params[:page], :per_page => 15)
    end

    def fees_billed_by_month #edit_all
        @projects = Project.current_and_billing.order("name ASC").paginate(:page => params[:page], :per_page => 15)
    end

    def update_all #for monthly_billing
      params['project'].keys.each do |id|
        @project = Project.find(id.to_i)
        @project.update_attributes(params['project'][id])
      end
      flash[:success] = "Projects updated successfully!"
      redirect_to(:back) 
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
            render 'new'
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
