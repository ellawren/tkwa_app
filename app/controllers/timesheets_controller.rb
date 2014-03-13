class TimesheetsController < ApplicationController
    include TimesheetsHelper

    def new
        @timesheet = Timesheet.new
    end

    def index
       @timesheets = Timesheet.all
       @user = current_user
       @holidays = Holiday.all
    end

    def admin
       @time_entries = TimeEntry.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    end

    def all
        @users = User.active_users
        @week = params[:week].to_i
        @year = params[:year].to_i 
    end

    def user_index
        @user = User.find(params[:id])
        @year = params[:year].to_i 
        @timesheets = Timesheet.find_all_by_user_id_and_year(@user.id, @year)
        if @year == Date.today.cwyear
            @week = Date.today.cweek
        elsif @year < Date.today.cwyear
            @week = weeks_in_year(@year)
        else
            @week = 1
        end
    end

    def edit
        @year = params[:year].to_i
        @week = params[:week].to_i
        @user = User.find(params[:id])

        if @week <= weeks_in_year(@year)
            @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(@user.id, @year, @week)
            @time_entries = @timesheet.time_entries.ordered
            @vacation_record = VacationRecord.find_or_create_by_year_and_user_id(Date.today.cwyear, @user.id)
            
            @data_array = DataRecord.where("user_id = ? AND year = ? AND start_week <= ? AND end_week >= ?", @user.id, @year, @week, @week)
            if @data_array.count > 0
                @data_record = @data_array[0]
                @goal = @data_record.hours_in_week * (@week - @data_record.start_week + 1) 
                @goal_with_overage = (@data_record.hours_in_week * (@week - @data_record.start_week + 1)) + -(@data_record.overage_from_prev.to_f) 
                @actual = total_hours_for(@user.id, @year, @week, @data_record.start_week) 

                if @timesheet.complete == false
                    1.times { @timesheet.time_entries.build }
                    1.times { @timesheet.non_billable_entries.build }
                end   
            end

        else
            flash[:error] = "Invalid date. Please try again."
            redirect_to timesheets_path
        end
    end

    def print
        @year = params[:year].to_i
        @week = params[:week].to_i
        @user = User.find(params[:id])

        if @week <= weeks_in_year(@year)
            # find matching data record
            @data_array = DataRecord.where("user_id = ? AND year = ? AND start_week <= ? AND end_week >= ?", @user.id, @year, @week, @week)
            if @data_array.count > 0
                @data_record = @data_array[0]
                @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(@user.id, @year, @week)
                @time_entries = @timesheet.time_entries.ordered
                @vacation_record = VacationRecord.find_or_create_by_year_and_user_id(Date.today.cwyear, @user.id)

                @goal = @data_record.hours_in_week * (@week - @data_record.start_week + 1)
                @goal_with_overage = (@data_record.hours_in_week * (@week - @data_record.start_week + 1)) + -(@data_record.overage_from_prev.to_f)
                @actual = total_hours_for(@user.id, @year, @week, @data_record.start_week)
            end
            # if no data records are found, go to page anyway - conditional will catch and show error message
            render :layout => 'timesheet-modal' 
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