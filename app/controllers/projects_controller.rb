class ProjectsController < ApplicationController
  def new
  	@project = Project.new
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
  end
  
  def tracking
    @project = Project.find(params[:id])
  end
  
  def schedule
    @project = Project.find(params[:id])
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
    session[:return_to] ||= request.referer
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated"
      redirect_to session[:return_to]
    else
      redirect_to session[:return_to]
    end
  end
end
