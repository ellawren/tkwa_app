class EmployeesController < ApplicationController
  
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee= Employee.find(params[:id])
  end

  #def timesheets
  #  @employee = Employee.find(params[:id])
  #  @contact = Contact.find(@employee.contact_id)
  #end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:success] = "Employee updated successfully!"
      redirect_to(:back) 
    else
      redirect_to(:back) 
    end
  end

  
end