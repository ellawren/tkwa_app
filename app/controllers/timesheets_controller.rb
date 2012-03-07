class TimesheetsController < ApplicationController
  def new
  	@timesheet = Timesheet.new
  end

  def edit
  	@timesheet = Timesheet.find(params[:id])
  end

  def index
  	@timesheets = Timesheet.all
  end

  def create
    @timesheet = Timesheet.new(params[:timesheet])
    if @timesheet.save
      flash[:success] = "Timesheet created!"
      redirect_to @timesheet
    else
      render 'new'
    end
  end

  def update
    @timesheet = Timesheet.find(params[:id])
    if @timesheet.update_attributes(params[:timesheet])
      flash[:success] = "Timesheet updated"
      redirect_to @timesheet
    else
      render 'edit'
    end
  end

  def destroy
    Timesheet.find(params[:id]).destroy
    flash[:success] = "Timesheet destroyed."
    redirect_to timesheets_path
  end
end
