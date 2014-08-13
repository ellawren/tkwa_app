class TimesheetsController < ApplicationController
    include TimesheetsHelper

    def new
        @timesheet = Timesheet.new
    end

    def index
       @user = current_user
       @holidays = Holiday.all
       @timesheet = Timesheet.where(user_id: @user.id, year: Date.today.cwyear, week: Date.today.cweek).first_or_create
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
        @timesheets = Timesheet.where(user_id: @user.id, year: @year)
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
        @timesheet = Timesheet.where(user_id: @user.id, year: params[:year].to_i, week: params[:week].to_i).first_or_create
        
        if @timesheet.complete == false
            1.times { @timesheet.time_entries.build }
            1.times { @timesheet.non_billable_entries.build }
        end   
    end

    def print
        @user = User.find(params[:id])
        @timesheet = Timesheet.where(user_id: @user.id, year: params[:year].to_i, week: params[:week].to_i).first_or_create
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