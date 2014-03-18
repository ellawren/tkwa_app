class TimesheetsController < ApplicationController
    include TimesheetsHelper

    def new
        @timesheet = Timesheet.new
    end

    def index
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
        @user = User.find(params[:id])
        @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(@user.id, params[:year].to_i, params[:week].to_i)
        
        if @timesheet.complete == false
            1.times { @timesheet.time_entries.build }
            1.times { @timesheet.non_billable_entries.build }
        end   
    end

    def print
        @user = User.find(params[:id])
        @timesheet = Timesheet.find_or_create_by_user_id_and_year_and_week(@user.id, params[:year].to_i, params[:week].to_i)
        render :layout => 'timesheet-modal'
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