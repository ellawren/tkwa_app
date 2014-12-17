class ContractorRolesController < ApplicationController

  	def index
        @contractor_roles = ContractorRole.all
    end

    def new
        @contractor_role = ContractorRole.new
    end

    def create
        @contractor_role = ContractorRole.new(params[:contractor_role])
        if @contractor_role.save
            redirect_to contractor_roles_path
        else
            render 'new'
        end
    end

    def edit
        @contractor_role = ContractorRole.find(params[:id])
    end

    def update
        @contractor_role = ContractorRole.find(params[:id])
        if @contractor_role.update_attributes(params[:contractor_role])
            flash[:success] = "Contractor role updated"
            redirect_to contractor_roles_path
        else
            render 'edit'
        end
    end

    def destroy
        ContractorRole.find(params[:id]).destroy
        flash[:success] = "Contractor role destroyed."
        redirect_to contractor_roles_path
    end

end
