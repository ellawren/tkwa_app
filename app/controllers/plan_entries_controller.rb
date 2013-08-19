class PlanEntriesController < ApplicationController
  def new
  	@plan_entry = PlanEntry.new
  end

  def edit
  	@plan_entry = PlanEntry.find(params[:id])
  end

  def index
  	@plan_entries = PlanEntry.all
  end

  def create
    @plan_entry = PlanEntry.new(params[:plan_entry])
    if @plan_entry.save
      flash[:success] = "Plan entry created!"
      redirect_to plan_entries_path
    else
      render 'new'
    end
  end

  def update
    @plan_entry = PlanEntry.find(params[:id])
    if @plan_entry.update_attributes(params[:plan_entry])
      flash[:success] = "Plan entry updated!"
      redirect_to plan_entries_path
    else
      render 'edit'
    end
  end

  def destroy
    PlanEntry.find(params[:id]).destroy
    flash[:success] = "Plan entry destroyed."
    redirect_to plan_entries_path
  end
end
