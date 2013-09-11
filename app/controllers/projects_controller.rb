class ProjectsController < ApplicationController
  require 'csv'
  autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]

  def new
  	@project = Project.new
    render :layout => 'projects_static' 
  end

  def current
    render :layout => 'projects_static' 
  end

  def import
    render :layout => 'projects_static' 
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def info
    @project = Project.find(params[:id])
  end

  def setup
    @project = Project.find(params[:id])
  end
  
  def scope
    @project = Project.find(params[:id])
  end

  def billing
    @project = Project.find(params[:id])
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

  def forecast
    @project = Project.find(params[:id])
  end

  def edit_forecast
    @project = Project.find(params[:id])
    render :layout => 'modal' 
  end

  def forecast_index
    @projects = Project.current.all
    render :layout => 'projects_static' 
  end

  def summary
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )
  end
  
  def team
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )
  end

  def csv_import  
    file = params[:file]  
    CSV.new(file.tempfile, :headers => true).each do |row|
        if row[3] != ''
          if Project.find_all_by_number(row[3]).count == 0
            Project.create!(:name => row[0],  
                       :location => row[1],  
                       :client => row[2],  
                       :number => row[3],    
                       :building_type => row[4],  
                       :billing_name => "#{row[5]} #{row[6]}", 
                       :billing_address => row[7], 
                       :billing_phone => row[8],  
                       :status => 'Current')  
          end
        end
    end  
    redirect_to projects_current_path
  end
  
  def tracking
    @project = Project.find(params[:id])
    @team_members = EmployeeTeam.find_all_by_project_id(@project.id)
    @all_entries = TimeEntry.find_all_by_project_id(@project.id)
    @phases = @project.available_phases
  end

  def fee_calc
    @project = Project.find(params[:id])
    @team_members = EmployeeTeam.find_all_by_project_id(@project.id)
    @phases = @project.available_phases
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
    @projects = @q.result(:distinct => true)
    @contact = Contact.find(current_user.employee.contact_id)
    @employee = current_user.employee
    if @projects.count == 1 
      redirect_to info_project_path(@projects.first(params[:id]))
    else
      render :layout => 'search' 
    end
  end
  
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to info_project_path(@project)
    else
      flash[:error] = "Project could not be created."
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
    redirect_to(:back) 
  end
  
end
