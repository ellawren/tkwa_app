class TimesheetsController < ApplicationController
  def new
   @timesheet = Timesheet.new
  end

  def edit
   @timesheet = Timesheet.find(params[:id])
  end

  def index
   #@timesheets = Timesheet.all
   @employee= Employee.find(params[:employee_id])
   @contact = Contact.find(@employee.contact_id)
   @timesheets = Timesheet.find(:all, :conditions => ['employee_id = ?', params[:employee_id]])
   @timesheet = Timesheet.find_by_employee_id(params[:employee_id])
  end

  def show

   @year = params[:year].to_i
   @week = params[:week].to_i

   @timesheet = Timesheet.find_or_create_by_employee_id_and_year_and_week(params[:id], params[:year], params[:week])
   @employee= Employee.find(@timesheet.employee_id)
   @contact = Contact.find(@employee.contact_id)

   #@time_entries = TimeEntry.find_all_by_timesheet_id(1)
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
    @year = @timesheet.year
    @week = @timesheet.week


    if @timesheet.update_attributes(params[:timesheet])
      flash[:success] = "Timesheet updated"
      redirect_to "/employees/#{@timesheet.employee_id}/timesheets/#{@timesheet.year}/#{@timesheet.week}"
    else
      flash[:error] = "Something went wrong."
      redirect_to "/employees/#{@timesheet.employee_id}/timesheets/#{@timesheet.year}/#{@timesheet.week}"
    end
  end

  def destroy
    Timesheet.find(params[:id]).destroy
    flash[:success] = "Timesheet destroyed."
    redirect_to timesheets_path
  end
end