class DataRecordsController < ApplicationController
    
    def index
        @users = User.all
        # make sure there is at least one data record for each user
        @users.each do |u|
            if DataRecord.find_all_by_year_and_user_id(Date.today.cwyear, u.id).count == 0
                DataRecord.create( :user_id => u.id, :year => Date.today.cwyear, :start_week => 1, :end_week => Date.new(this_year, 12, 28).cweek )
            end
        end
        @data_records = DataRecord.all
    end

    def user_index
        @user = User.find(params[:user_id])
        @data_records = DataRecord.find_all_by_user_id(params[:user_id])
    end

    def new
        @data_record = DataRecord.new
        render :layout => 'modal' 
    end

    def create
        @data_record = DataRecord.new(params[:data_record])
        if @data_record.save
            redirect_to(:back) 
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:user_id])
        @data_record = DataRecord.find(params[:id])
        render :layout => 'modal' 
    end

    def update
        @data_record = DataRecord.find(params[:id])
        if @data_record.update_attributes(params[:data_record])
            flash[:success] = "Employee data updated successfully!"
            redirect_to(:back) 
        else
            redirect_to(:back) 
        end
    end

    def destroy
        DataRecord.find(params[:id]).destroy
        flash[:success] = "Data record destroyed."
        redirect_to(:back) 
    end

end