class ConsultantsController < ApplicationController

  	def new
  	    @consultant = Consultant.new
    end

    def show
  	    @consultant = Consultant.find(params[:id])
    end

    def edit
  	    @consultant = Consultant.find(params[:id])
    end

    def index
  	    @consultants = Consultant.order("name ASC")
    end

    def create
        @consultant = Consultant.new(params[:consultant])
        if @consultant.save
            flash[:success] = "Consultant created!"
            redirect_to consultants_path
        else
            render 'new'
        end
    end

    def update
        @consultant = Consultant.find(params[:id])
        if @consultant.update_attributes(params[:consultant])
            flash[:success] = "Consultant updated!"
            redirect_to consultants_path
        else
            render 'edit'
        end
    end

    def destroy
        Consultant.find(params[:id]).destroy
        flash[:success] = "Consultant destroyed."
        redirect_to consultants_path
    end

end
