class DataRecordsController < ApplicationController
  
  def index
    @users = User.all
  end

  def edit
    @data_record = DataRecord.find_or_create_by_user_id_and_year(params[:id], params[:year])
    @user = User.find(@data_record.user_id)
    render :layout => 'modal' 
  end

  def update
    @data_record = DataRecord.find(params[:id])
    if @data_record.update_attributes(params[:data_record])
      flash[:success] = "Employee data updated successfully!"
      redirect_to users_path
    else
      redirect_to(:back) 
    end
  end

 
  
end