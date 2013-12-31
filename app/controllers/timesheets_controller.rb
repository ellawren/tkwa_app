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
    if year_begin(1,Date.today.year + 1) <= Date.today # check if next year's start date is this week
        # if yes, kick the timesheet link into next year
        @curr_year = Date.today.year + 1
        @curr_week = 1
    else
        # otherwise, use this year
        @curr_year = this_year
        @curr_week = this_week
    end
   #@contact = Contact.find(@employee.contact_id)
   #@timesheets = Timesheet.find(:all, :conditions => ['employee_id = ?', params[:employee_id]])
   #@timesheet = Timesheet.find_by_employee_id(params[:employee_id])
  end


  def show
    if year_begin(1,Date.today.year + 1) <= Date.today # check if next year's start date is this week
        # if yes, kick the timesheet tabnav links  into next year
        @curr_year = Date.today.year + 1
    else
        # otherwise, use this year
        @curr_year = this_year
    end

    @year = params[:year].to_i
    @week = params[:week].to_i

    if @week <= 53
        @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(params[:id], params[:year], params[:week])
        @user= User.find(@timesheet.user_id)
        @data_record = DataRecord.find_or_create_by_user_id_and_year(@user.id, @timesheet.year)

        1.times { @timesheet.time_entries.build }
        1.times { @timesheet.non_billable_entries.build }

        render :layout => 'search' 
    else
      flash[:error] = "Invalid date."
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
      flash[:error] = "Something went wrong."
      redirect_to(:back) 
    end
  end

  def destroy
    Timesheet.find(params[:id]).destroy
    flash[:success] = "Timesheet destroyed."
    redirect_to timesheets_path
  end
end