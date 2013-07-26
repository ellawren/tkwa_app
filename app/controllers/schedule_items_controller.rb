class ScheduleItemsController < ApplicationController
	
	def show
	    @schedule_item = ScheduleItem.find(params[:id])
	end

	def new
	    @schedule_item = ScheduleItem.new
	    @project = Project.find(params[:project_id])
	    render :layout => 'modal' 
	end

	def create
	    @schedule_item = ScheduleItem.new(params[:schedule_item])
	    if @schedule_item.save
	      redirect_to schedule_project_path(Project.find(@schedule_item.project_id))
	    else
	    	flash[:error] = 'Schedule item could not be created.'
	    	redirect_to(:back) 
	    end
	end

	def edit
	    @schedule_item = ScheduleItem.find(params[:id])
	    @project = Project.find(@schedule_item.project_id)
	    render :layout => 'modal' 
	end

	def update
	    @schedule_item = ScheduleItem.find(params[:id])
	    if @schedule_item.update_attributes(params[:schedule_item])
	      flash[:success] = "Schedule Item updated!"
	      redirect_to schedule_project_path(Project.find(@schedule_item.project_id))
	    else
	      flash[:error] = 'Schedule item could not be updated.'
	      redirect_to(:back) 
	    end
	end

	def destroy
	    ScheduleItem.find(params[:id]).destroy
	    flash[:success] = "Schedule item deleted."
	    redirect_to(:back) 
	end

end