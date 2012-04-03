class DataRecordsController < ApplicationController
  

  def edit
    @data_record = DataRecord.find_or_create_by_employee_id_and_year(params[:id], params[:year])
    render :layout => 'modal' 
  end

  def update
    @data_record = DataRecord.find(params[:id])
    if @data_record.update_attributes(params[:data_record])
      flash[:success] = "Employee data updated successfully!"
      redirect_to employees_path
    else
      redirect_to(:back) 
    end
  end

 
  
end