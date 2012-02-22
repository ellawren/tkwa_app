class ProjectsController < ApplicationController
  def new
  	@project = Project.new
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to @project
    else
      render 'new'
    end
  end
end
