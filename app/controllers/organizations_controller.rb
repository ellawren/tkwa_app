class OrganizationsController < ApplicationController
  def new
  	    @organization = Organization.new
    end

    def show
  	    @organization = Organization.find(params[:id])
    end

    def edit
  	    @organization = Organization.find(params[:id])
    end

    def index
        @q = Organization.order("name ASC").search(params[:q])
        @organizations = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30).order('name ASC')
        @all_organizations = Organization.order("name ASC")
        if params.has_key?(:q) && @organizations.count == 1 
            redirect_to organization_path(@organizations.first(params[:id]))
        else
            render 'index' 
        end
    end

    def create
        @organization = Organization.new(params[:organization])
        if @organization.save
            flash[:success] = "Organization created!"
            redirect_to organizations_path
        else
            render 'new'
        end
    end

    def update
        @organization = Organization.find(params[:id])
        if @organization.update_attributes(params[:organization])
            flash[:success] = "Organization updated!"
            redirect_to organization_path(@organization)
        else
            render 'edit'
        end
    end

    def destroy
        Organization.find(params[:id]).destroy
        flash[:success] = "Organization destroyed."
        redirect_to organizations_path
    end

end
