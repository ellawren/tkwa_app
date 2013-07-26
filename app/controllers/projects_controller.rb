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
  
  def scope
    @project = Project.find(params[:id])
  end

  def billing
    @project = Project.find(params[:id])
  end

  def shop_drawings
    @project = Project.find(params[:id])
  end

  def patterns
    @project = Project.find(params[:id])
  end

  def marketing
    @project = Project.find(params[:id])
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

            estimated = @project.sum_est
            actual = @project.sum_actual
            @percent_complete = actual/estimated *100

            @pd_pc = @project.phase_est('pd').to_f/estimated *100
            @sd_pc = @project.phase_est('sd').to_f/estimated *100
            @dd_pc = @project.phase_est('dd').to_f/estimated *100
            @cd_pc = @project.phase_est('cd').to_f/estimated *100
            @bid_pc = @project.phase_est('bid').to_f/estimated *100
            @cca_pc = @project.phase_est('cca').to_f/estimated *100
            @int_pc = @project.phase_est('int').to_f/estimated *100
            @his_pc = @project.phase_est('his').to_f/estimated *100
            @add_pc = @project.phase_est('add').to_f/estimated *100

            @dd_left = @pd_pc + @sd_pc
            @cd_left = @pd_pc + @sd_pc + @dd_pc
            @bid_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc
            @cca_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc
            @int_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc
            @his_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc + @int_pc
            @add_left = @pd_pc + @sd_pc + @dd_pc + @cd_pc + @bid_pc + @cca_pc + @int_pc + @his_pc
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
    @q = Project.search(params[:q])
    @projects = @q.result(:distinct => true)
    @contact = Contact.find(current_user.employee.contact_id)

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
      redirect_to(:back) 
    end
  end
  
  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted."
    redirect_to(:back) 
  end
  
end
