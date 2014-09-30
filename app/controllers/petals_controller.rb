class PetalsController < ApplicationController

    def new
  	    @petal = Petal.new
    end

    def show
  	    @petal = Petal.find(params[:id])
    end

    def edit
  	    @petal = Petal.find(params[:id])
    end

    def index
  	    @petals = Petal.order("numerical_order ASC")
    end

    def create
        @petal = Petal.new(params[:petal])
        if @petal.save
            flash[:success] = "Petal created!"
            redirect_to edit_petal_path(@petal)
        else
            render 'new'
        end
    end

    def update
        @petal = Petal.find(params[:id])
        if @petal.update_attributes(params[:petal])
            flash[:success] = "Petal updated!"
            redirect_to edit_petal_path(@petal)
        else
            render 'edit'
        end
    end

    def destroy
        LivingBuildingCategory.find(params[:id]).destroy
        flash[:success] = "Petal destroyed."
        redirect_to petals_path
    end

end
