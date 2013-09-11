class CompaniesController < ApplicationController

    def show
        @company = Company.find(params[:id])
        @teams = ConsultantTeam.find_all_by_consultant_id(@company.id)
    end

    def index
      	@companies = Company.all
    end

    def search
       @q = Company.search(params[:q])
       @companies = @q.result(:distinct => true)
       render :layout => 'modal'
    end

    def create
        @company = Company.new(params[:company])
        if @company.save
            render json: @company, :layout => false # used for ajax create via contact page
        else
            render 'new'
        end
    end

    def update
        @company = Company.find(params[:id])
        if @company.update_attributes(params[:company])
            flash[:success] = "Contact updated successfully!"
            redirect_to(:back)
        else
            render 'edit'
        end
    end

    def destroy
        Company.find(params[:id]).destroy
        flash[:success] = "Company destroyed."
        redirect_to companies_path
    end

end
