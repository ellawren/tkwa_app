class PhasesController < ApplicationController

    def new
  	    @phase = Phase.new
    end

    def edit
  	    @phase = Phase.find(params[:id])
    end

    def index
  	    @phases = Phase.all
    end

    def modal
        @phases = Phase.all
        render :layout => 'modal' 
    end

    def create
        @phase = Phase.new(params[:phase])
        if @phase.save
            flash[:success] = "Phase created!"
            redirect_to phases_path
        else
            render 'new'
        end
    end

    def update
        @phase = Phase.find(params[:id])
        if @phase.update_attributes(params[:phase])
            flash[:success] = "Phase updated!"
            redirect_to phases_path
        else
            render 'edit'
        end
    end

    def destroy
        Phase.find(params[:id]).destroy
        flash[:success] = "Phase destroyed."
        redirect_to phases_path
    end

end
