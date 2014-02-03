class EmployeeRolesController < ApplicationController
	
	def index
	    @employee_roles = EmployeeRole.all
	end

	def show
	    @employee_role = EmployeeRole.find(params[:id])
	end

	def new
	    @employee_role = EmployeeRole.new
	end

	def create
	    @employee_role = EmployeeRole.new(params[:employee_role])
	    if @employee_role.save
	      	redirect_to employee_roles_path
	    else
	      	render 'new'
	    end
	end

	def edit
	    @employee_role = EmployeeRole.find(params[:id])
	end

	def update
	    @employee_role = EmployeeRole.find(params[:id])
	    if @employee_role.update_attributes(params[:employee_role])
	      	flash[:success] = "Employee role updated"
	      	redirect_to employee_roles_path
	    else
	      	render 'edit'
	    end
	end

	def destroy
	    EmployeeRole.find(params[:id]).destroy
	    flash[:success] = "Employee role destroyed."
	    redirect_to employee_roles_path
	end

end
