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
        @user = User.find(@timesheet.user_id)
        
        # find all data records for user/year
        data_array = []
        DataRecord.find_all_by_user_id_and_year(@user.id, @timesheet.year).each do |d|
            data_array.push(d)
        end
        # if none have been created, make one and use that (with default values)
        if data_array.size == 0 
            @data_record = DataRecord.create( :user_id => @user.id, :year => @year, :start_week => 1, :end_week => Date.new(@year, 12, 28).cweek ) 
        # if there is at least one, check to see if it covers this week
        else
            data_array.each do |d|
                if @week >= d.start_week && @week <= d.end_week 
                    @data_record = d
                end
            end
            #if all are checked and there are no matches, then throw an error and return to the index
            if @data_record.nil?
                flash[:error] = "Employee data is not set up for this week. Please see admin."
                redirect_to timesheets_path and return
            end
        end

        # -----------------------------

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