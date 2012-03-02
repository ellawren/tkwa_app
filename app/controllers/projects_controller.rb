class ProjectsController < ApplicationController
  autocomplete :contact, :name, :full => true, :extra_data => [:work_address, :work_phone, :work_ext, :work_email]

  def new
  	@project = Project.new
    render :layout => 'new_project' 
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
  
  def team
    @project = Project.find(params[:id])
    @consultant_list = ConsultantTeam.find(:all, :select => 'DISTINCT consultant_id', :conditions => [ "project_id = #{@project.id}" ] )

  end
  
  def tracking
    @project = Project.find(params[:id])
  end
  
  def schedule
    @project = Project.find(params[:id])
  end
  
  def index
    @projects = Project.paginate(page: params[:page])
    render :layout => 'index_projects'
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
      redirect_to(:back) 
    end
  end
  
  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted."
    redirect_to projects_path
  end
  
end
