class EmployeesController < ApplicationController

	def update

        @employee = Employee.find(params[:id])
        if @employee.update_attributes(params[:employee])
            flash[:success] = "Employee updated successfully!"
            redirect_to(:back) 
        else
            render 'edit'
        end
    end

end