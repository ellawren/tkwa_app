class PotentialProjectsController < ApplicationController
  def new
  	@potential_project = PotentialProject.new
    render :layout =>  'potential_projects_static'
  end

  def show
  	@potential_project = PotentialProject.find(params[:id])
  end

  def info
  	@potential_project = PotentialProject.find(params[:id])
  end

  def scope
    @potential_project = PotentialProject.find(params[:id])
  end

  def team
    @potential_project = PotentialProject.find(params[:id])
  end

  def schedule
    @potential_project = PotentialProject.find(params[:id])
  end

  def tracking
    @potential_project = PotentialProject.find(params[:id])
  end

  def patterns
    @potential_project = PotentialProject.find(params[:id])
  end

  def index
  	@potential_projects = PotentialProject.all
    render :layout =>  'potential_projects_static'
  end

  def create
    @potential_project = PotentialProject.new(params[:potential_project])
    if @potential_project.save
      flash[:success] = "Project created successsfully!"
      redirect_to info_potential_project_path
    else
      render 'new'
    end
  end

  def update
    @potential_project = PotentialProject.find(params[:id])
    if @potential_project.update_attributes(params[:potential_project])
      flash[:success] = "Project updated."
      redirect_to(:back)
    else
      render 'edit'
    end
  end

  def destroy
    PotentialProject.find(params[:id]).destroy
    flash[:success] = "Project destroyed."
    redirect_to potential_projects_path
  end

end
