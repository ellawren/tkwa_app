class TasksController < ApplicationController
  def new
  	@task = Task.new
  end

  def edit
  	@task = Task.find(params[:id])
  end

  def index
  	@tasks = Task.all
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:success] = "Task created!"
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = "Task updated!"
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task destroyed."
    redirect_to tasks_path
  end
end
