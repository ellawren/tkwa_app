class DataRecordsController < ApplicationController
  
  def index
    @users = User.all
  end

  def edit
    if User.where(id: params[:id]).present?
      @data_record = DataRecord.find_or_create_by_user_id_and_year(params[:id], params[:year])
      @user = User.find(params[:id])
      render :layout => 'modal' 
    else
      redirect_to data_records_path
      flash[:error] = "Not a valid user id."
    end
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