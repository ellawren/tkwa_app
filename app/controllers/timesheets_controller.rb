class TimesheetsController < ApplicationController
  include TimesheetsHelper

  def new
   @timesheet = Timesheet.new
  end

  def edit
   @timesheet = Timesheet.find(params[:id])
  end

  def index
   @timesheets = Timesheet.all
   @user = current_user
  end


  def show
    @year = params[:year].to_i
    @week = params[:week].to_i

    if @week <= weeks_in_year(@year)
        @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(params[:id], params[:year], params[:week])
        @user= User.find(@timesheet.user_id)
        @data_record = DataRecord.find_or_create_by_user_id_and_year(@user.id, @timesheet.year)

        if @timesheet.open?
          1.times { @timesheet.time_entries.build }
          1.times { @timesheet.non_billable_entries.build }
        end        
        render :layout => 'search' 
    else
      flash[:error] = "Invalid date. Please try again."
      redirect_to timesheets_path
    end
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
      flash[:success] = "Timesheet updated!"
      redirect_to(:back) 
    else
      flash[:error] = "Timesheet could not be updated. Please try again."
      redirect_to(:back) 
    end
  end

  def destroy
    Timesheet.find(params[:id]).destroy
    flash[:success] = "Timesheet destroyed."
    redirect_to timesheets_path
  end
end