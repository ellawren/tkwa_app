class TimesheetsController < ApplicationController
  def new
   @timesheet = Timesheet.new
  end

  def edit
   @timesheet = Timesheet.find(params[:id])
  end

  def index
   @timesheets = Timesheet.all
   @employee = current_user.employee
   #@contact = Contact.find(@employee.contact_id)
   #@timesheets = Timesheet.find(:all, :conditions => ['employee_id = ?', params[:employee_id]])
   #@timesheet = Timesheet.find_by_employee_id(params[:employee_id])
  end


  def show

   @year = params[:year].to_i
   @week = params[:week].to_i

   @timesheet = Timesheet.find_or_create_by_employee_id_and_year_and_week(params[:id], params[:year], params[:week])
   @employee= Employee.find(@timesheet.employee_id)
   @contact = Contact.find(@employee.contact_id)
   @data_record = DataRecord.find_or_create_by_employee_id_and_year(@employee.id, @timesheet.year)

   1.times { @timesheet.time_entries.build }
   1.times { @timesheet.non_billable_entries.build }

   render :layout => 'search' 
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