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
       @holidays = Holiday.all
    end

    def all
        @user = User.find(params[:id])
        @timesheets = Timesheet.find_all_by_user_id(params[:id])
    end


    def show
        @year = params[:year].to_i
        @week = params[:week].to_i
        @user = User.find(params[:id])

        if @week <= weeks_in_year(@year)
            # find matching data record
            @data_array = DataRecord.where("user_id = ? AND year = ? AND start_week <= ? AND end_week >= ?", @user.id, @year, @week, @week)
            if @data_array.count > 0
                @data_record = @data_array[0]
                @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(@user.id, @year, @week)
                
                @goal = @data_record.hours_in_week * (@week - @data_record.start_week + 1)
                @goal_with_overage = (@data_record.hours_in_week * (@week - @data_record.start_week + 1)) + -(@data_record.overage_from_prev.to_f)
                @actual = total_hours_for(params[:id], @year, @week, @data_record.start_week)

                if @timesheet.open?
                    1.times { @timesheet.time_entries.build }
                    1.times { @timesheet.non_billable_entries.build }
                end   
            end
            # if no data records are found, go to page anyway - conditional will catch and show error message
            render :layout => 'search' 
        else
            flash[:error] = "Invalid date"
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
        redirect_to all_timesheets_path
    end
    
end