class VacationRecordsController < ApplicationController

  	def index
        @users = User.all
        # make sure there is at least one data record for each user
        @users.each do |u|
            if VacationRecord.find_all_by_year_and_user_id(Date.today.cwyear, u.id).count == 0
                VacationRecord.create( :user_id => u.id, :year => Date.today.cwyear )
            end
        end
        @vacation_records = VacationRecord.all
    end

    def user_index
        @user = User.find(params[:user_id])
        @vacation_records = VacationRecord.find_all_by_user_id(params[:user_id])
    end

    def new
        @vacation_record = VacationRecord.new
        render :layout => 'modal' 
    end

    def create
        @vacation_record = VacationRecord.new(params[:vacation_record])
        if @vacation_record.save
            redirect_to(:back) 
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:user_id])
        @vacation_record = VacationRecord.find(params[:id])
        render :layout => 'modal' 
    end

    def update
        @vacation_record = VacationRecord.find(params[:id])
        if @vacation_record.update_attributes(params[:vacation_record])
            flash[:success] = "Vacation record updated successfully!"
            redirect_to(:back) 
        else
            redirect_to(:back) 
        end
    end

    def destroy
        VacationRecord.find(params[:id]).destroy
        flash[:success] = "Vacation record destroyed."
        redirect_to(:back) 
    end

end
